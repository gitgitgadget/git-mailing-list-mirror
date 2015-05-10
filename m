From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH 1/2] completion: add a helper function to get config
 variables
Date: Sun, 10 May 2015 15:16:52 +0200
Message-ID: <20150510151652.Horde.FOfYcnwZZkdBJUYkl0pDQg1@webmail.informatik.kit.edu>
References: <1431262218-7304-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 10 15:20:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrR9b-0001Zn-K4
	for gcvg-git-2@plane.gmane.org; Sun, 10 May 2015 15:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbbEJNRF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 May 2015 09:17:05 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:45306 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751171AbbEJNRD convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2015 09:17:03 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1YrR6L-0007Iv-1k; Sun, 10 May 2015 15:17:01 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1YrR6C-0004ES-R0; Sun, 10 May 2015 15:16:52 +0200
Received: from x590d7ec1.dyn.telefonica.de (x590d7ec1.dyn.telefonica.de
 [89.13.126.193]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Sun, 10 May 2015 15:16:52 +0200
In-Reply-To: <1431262218-7304-1-git-send-email-szeder@ira.uka.de>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1431263821.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268732>


Quoting SZEDER G=C3=A1bor <szeder@ira.uka.de>:

> Currently there are a few completion functions that perform similar '=
git
> config' queries and filtering to get config variable names: the compl=
etion
> of pretty aliases, aliases, and remote groups for 'git remote update'=
=2E
>
> Unify those 'git config' queries in a helper function to eliminate co=
de
> duplication.
>
> Though the helper functions to get pretty aliases and alieses are red=
uced
> to mere one-liner wrappers around the newly added function, keep thes=
e
> helpers still, because users' completion functions out there might de=
pend
> on them.  And they keep their callers a tad easier to read, too.
>
> Add tests for the pretty alias and alias helper to show that they wor=
k
> as before; not for the remote groups query, though, because that's no=
t
> extracted into a helper function and it's not worth the effort to do =
so
> for a sole callsite.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
> ---
> @@ -2260,12 +2259,7 @@ _git_remote ()
>  		__git_complete_remote_or_refspec
>  		;;
>  	update)
> -		local i c=3D'' IFS=3D$'\n'
> -		for i in $(git --git-dir=3D"$(__gitdir)" config --get-regexp =20
> "remotes\..*" 2>/dev/null); do
> -			i=3D"${i#remotes.}"
> -			c=3D"$c ${i/ */}"
> -		done
> -		__gitcomp "$c"
> +		__gitcomp "$(__git_get_config_variables "remotes")"

I just noticed that this query for remote groups does lack that =20
filtering case statement eliminated in the next patch and the regex is =
=20
not limited to the beginning of the config variable name.
So, let's suppose we have a branch named 'remotes', for which we add a =
=20
branch description (and no remote groups, for symplicity's sake):

   $ git config branch.remotes.description uh-oh
   $ git remote update <TAB>

This will complete to:

   $ git remote update branch.remotes.description

and that's obviously bad.

This series fixes this.

Best,
G=C3=A1bor
