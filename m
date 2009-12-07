From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH v3 5/8] Support taking over transports
Date: Mon, 7 Dec 2009 09:49:47 -0800
Message-ID: <20091207174947.GF17173@spearce.org>
References: <1260116931-16549-1-git-send-email-ilari.liusvaara@elisanet.fi> <1260116931-16549-6-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Mon Dec 07 18:50:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHhij-0003Ng-LA
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 18:50:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbZLGRtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 12:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935496AbZLGRtt
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 12:49:49 -0500
Received: from mail-yw0-f198.google.com ([209.85.211.198]:38568 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935489AbZLGRts (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 12:49:48 -0500
Received: by ywh36 with SMTP id 36so4516390ywh.15
        for <git@vger.kernel.org>; Mon, 07 Dec 2009 09:49:55 -0800 (PST)
Received: by 10.101.132.5 with SMTP id j5mr5811365ann.108.1260208193810;
        Mon, 07 Dec 2009 09:49:53 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 21sm2613440yxe.55.2009.12.07.09.49.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Dec 2009 09:49:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1260116931-16549-6-git-send-email-ilari.liusvaara@elisanet.fi>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134767>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> wrote:
> @@ -109,9 +120,21 @@ static struct child_process *get_helper(struct transport *transport)
>  		die("Unable to run helper: git %s", helper->argv[0]);
>  	data->helper = helper;
>  
> +	/* Open the output as FILE* so strbuf_getline() can be used.
> +	   Do this with duped fd because fclose() will close the fd,
> +	   and stuff like disowning will require the fd to remain.
> +
> +	   Set the stream to unbuffered because some reads are critical
> +	   in sense that any overreading will cause deadlocks.
> +	*/
> +        duped = dup(helper->out);

Formatting error here, the line is indented wrong.

> +	if (duped < 0)
> +		die_errno("Can't dup helper output fd");
> +	data->out = xfdopen(duped, "r");
> +	setvbuf(data->out, NULL, _IONBF, 0);

I wonder if this is really a good idea.  Most helpers actually
use a lot of text based IO to communicate.  Disabling buffering
for those helpers to avoid overreading the advertisement from a
connect is a problem.

Maybe we could leave buffering on, but use a handshake protocol
with the helper during connect:

  (1) > "connect git-upload-pack\n"
  (2) < "\n"
  (3) > "begin\n"

During 2 we are still buffered, but the only content on the pipe
should be the single blank line, so we pull that in and the FILE*
buffer should be empty.

After writing message 2 the remote helper blocks reading for the
"begin\n" message 3.  This gives the transport-helper.c code time
to switch off the FILE* and start using raw IO off the pipe before
any data starts coming down the line.

It does mean that the helper may need to run unbuffered IO, but
if the helper is only a smart helper supporting connect then this
isn't really a problem.  It can run buffered IO until connect is
received, switch to unbuffered, and use unbuffered for the single
"begin\n" message it has to consume before it starts writing output
or reading input.

-- 
Shawn.
