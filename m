From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Unable to clone via git protocol / early EOF / index-pack failed
Date: Sat, 26 Mar 2011 18:58:22 +0100
Message-ID: <vpq8vw1epc1.fsf@bauges.imag.fr>
References: <20110324102703.GH4534@prithivi.gnumonks.org>
	<loom.20110326T180713-801@post.gmane.org>
	<loom.20110326T183100-349@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Holger Freyther <zecke@selfish.org>
X-From: git-owner@vger.kernel.org Sat Mar 26 19:01:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3Xnb-0000f8-Bf
	for gcvg-git-2@lo.gmane.org; Sat, 26 Mar 2011 19:01:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752185Ab1CZSBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Mar 2011 14:01:13 -0400
Received: from imag.imag.fr ([129.88.30.1]:60513 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751964Ab1CZSBN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Mar 2011 14:01:13 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id p2QHwN9m019574
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 26 Mar 2011 18:58:23 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Q3Xkk-0002I2-Qu; Sat, 26 Mar 2011 18:58:22 +0100
In-Reply-To: <loom.20110326T183100-349@post.gmane.org> (Holger Freyther's
	message of "Sat, 26 Mar 2011 17:34:31 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sat, 26 Mar 2011 18:58:23 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170062>

Holger Freyther <zecke@selfish.org> writes:

> Holger Freyther <zecke <at> selfish.org> writes:
>
>
>> It is a bit difficult to track all the processes that get started and what they
>> should do and to figure out at which point the fd for the tcp socket is really
>> closed.
>
> If I do the below hack it is working fine. Adding a fflush(NULL).. or a
> close(fileno(stdout)).. fsync... sched_yield() is not fixing it though.
>
> diff --git a/upload-pack.c b/upload-pack.c
> index 72aa661..4cd12c9 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -695,6 +695,8 @@ static void upload_pack(void)
>                 get_common_commits();
>                 create_pack_file();
>         }
> +
> +       sleep(1);
>  }
>  
>  int main(int argc, char **argv)

That reminds me an issue I had with git over SSH. The problem was indeed
not Git-related:

  http://readlist.com/lists/securityfocus.com/secureshell/0/3071.html

In short, when sending 196481 bytes or more, _and_ if the server did not
consume the data fast enough, then the connection was closed after
65536=2^16 bytes.

That was on RHEL, and upgrading the kernel solved the issue. Scary...

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
