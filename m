From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [RFC PATCH v3 5/8] Support taking over transports
Date: Mon, 7 Dec 2009 23:19:08 +0200
Message-ID: <20091207211907.GA3916@Knoppix>
References: <1260116931-16549-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1260116931-16549-6-git-send-email-ilari.liusvaara@elisanet.fi>
 <20091207174947.GF17173@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Dec 07 22:19:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHkzK-00011q-29
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 22:19:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965020AbZLGVTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 16:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbZLGVTG
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 16:19:06 -0500
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:35762 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935590AbZLGVTF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 16:19:05 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id 4C2768BE61;
	Mon,  7 Dec 2009 23:19:11 +0200 (EET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A006A24A584; Mon, 07 Dec 2009 23:19:11 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 251562BD43;
	Mon,  7 Dec 2009 23:19:09 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <20091207174947.GF17173@spearce.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134787>

On Mon, Dec 07, 2009 at 09:49:47AM -0800, Shawn O. Pearce wrote:
> 
> > +	if (duped < 0)
> > +		die_errno("Can't dup helper output fd");
> > +	data->out = xfdopen(duped, "r");
> > +	setvbuf(data->out, NULL, _IONBF, 0);
> 
> I wonder if this is really a good idea.  Most helpers actually
> use a lot of text based IO to communicate.  Disabling buffering
> for those helpers to avoid overreading the advertisement from a
> connect is a problem.

I dropped the buffering change. 
 
> Maybe we could leave buffering on, but use a handshake protocol
> with the helper during connect:
> 
>   (1) > "connect git-upload-pack\n"
>   (2) < "\n"
>   (3) > "begin\n"
> 
> During 2 we are still buffered, but the only content on the pipe
> should be the single blank line, so we pull that in and the FILE*
> buffer should be empty.

Doesn't work. Stream buffering can only be changed before first
I/O.
 
I figured out a solution. Dup the file descriptor second time and
make another FILE* for it. Then send the connect and read the
response over the new stream. This avoids overreading and allows
other I/O to be buffered. After connect attempt, the new streaam
can be closed.

This way most of the I/O can be buffered, only reading responses
to connect commands can't, and that is at most 1 byte if fallbacks
aren't required. And the thing fits nicely inside _process_connect().
Oh, and no protocol change needed.

-Ilari
