From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git-receive-pack --stateless-rpc
Date: Thu, 17 Jun 2010 07:00:48 -0700
Message-ID: <AANLkTimZxcljR4soYWVeExr27Md7jmsE1Mfx3Vcbf9SI@mail.gmail.com>
References: <AANLkTikwu4iKnG-DzclRPFNF7djNKZ31xR82aO0ryVJ3@mail.gmail.com> 
	<AANLkTikbUp7_22alAbgNFO30R7vkPUAOr7qvJ6a86Zc7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Yiyi Sun <yiyisun@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 17 16:01:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPFee-0001LI-Dg
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 16:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760046Ab0FQOBL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jun 2010 10:01:11 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45899 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754001Ab0FQOBK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jun 2010 10:01:10 -0400
Received: by iwn9 with SMTP id 9so6813190iwn.19
        for <git@vger.kernel.org>; Thu, 17 Jun 2010 07:01:09 -0700 (PDT)
Received: by 10.231.126.79 with SMTP id b15mr11507763ibs.80.1276783269473; 
	Thu, 17 Jun 2010 07:01:09 -0700 (PDT)
Received: by 10.231.200.195 with HTTP; Thu, 17 Jun 2010 07:00:48 -0700 (PDT)
In-Reply-To: <AANLkTikbUp7_22alAbgNFO30R7vkPUAOr7qvJ6a86Zc7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149309>

On Thu, Jun 17, 2010 at 6:45 AM, Yiyi Sun <yiyisun@gmail.com> wrote:
> I am creating a Git smart HTTP protocol wrapper and run into two
> problem. I tried the msysGit mailing list and was told to ask them to
> the main git mailing list.
>
> Here is the story. During 'git push',=A0 I successfully processed the
> initial GET request of '/info/refs?service=3Dgit-receive-pack' by
> sending back the output of 'git receive-pack --stateless-rpc
> --advertise-refs'. Then msysGit did a the POST request. I
> invoked 'git receive-pack --stateless-rpc', which returned:
>
> 0030 000eunpack ok
> 0019ok refs/heads/master
> 00000000

That doesn't look right to me.  There appears to be a space at the
start of the packet (between 0030 and 000e), which would confuse the
protocol.  Otherwise, that appears to be a valid response from
receive-pack assuming the client asked for side-band-64k in the
request, and it pushed only refs/heads/master.

> Question #1,=A0Is the result supposed to be something below instead?
>
> 000eunpack ok
> 0019ok refs/heads/master
> 0000

Depends on whether or not the client asked for side-band-64k.  If it
did, we wrap it up in a another pkt-line framing like above, and end
with another flush-pkt.  If the client didn't ask for side-band-64k,
then the above would be the correct response.

> Question #2, msysGit cannot parse the result, it displays error messa=
ge:
>
> fatal: protocol error: bad line length character:
> 003
> fatal: The remote end hung up unexpectedly

This is weird.  "003" isn't valid, its not 4 bytes long.  What was
that trailing final 4th byte right there?  If its a space like it is
above (though then its really in the wrong spot, isn't it?) that would
throw it all off.

It sounds to me like your wrapper is mangling the data that is passing
through it on the way back to the client.

--=20
Shawn.
