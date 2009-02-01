From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] mergetool: fix running mergetool in sub-directories
Date: Sat, 31 Jan 2009 17:32:45 -0800
Message-ID: <7v63jv0wn6.fsf@gitster.siamese.dyndns.org>
References: <1233357611-31820-1-git-send-email-charles@hashpling.org>
 <1233357611-31820-2-git-send-email-charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Jonas =?utf-8?Q?Flod=C3=A9n?= <jonas.floden@gmail.com>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Sun Feb 01 02:34:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTRE2-0003qx-Ft
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 02:34:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753352AbZBABcx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 20:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753300AbZBABcx
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 20:32:53 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40910 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753288AbZBABcw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 20:32:52 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9C8229585F;
	Sat, 31 Jan 2009 20:32:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 476359585D; Sat,
 31 Jan 2009 20:32:46 -0500 (EST)
In-Reply-To: <1233357611-31820-2-git-send-email-charles@hashpling.org>
 (Charles Bailey's message of "Fri, 30 Jan 2009 23:20:11 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3DAB4F8E-F000-11DD-92DE-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107965>

Charles Bailey <charles@hashpling.org> writes:

> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index aefdca7..87fa88a 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -13,7 +13,6 @@ SUBDIRECTORY_OK=Yes
>  OPTIONS_SPEC=
>  . git-sh-setup
>  require_work_tree
> -prefix=$(git rev-parse --show-prefix)
>  
>  # Returns true if the mode reflects a symlink
>  is_symlink () {
> @@ -131,7 +130,7 @@ checkout_staged_file () {
>      tmpfile=$(expr "$(git checkout-index --temp --stage="$1" "$2")" : '\([^	]*\)	')
>  
>      if test $? -eq 0 -a -n "$tmpfile" ; then
> -	mv -- "$tmpfile" "$3"
> +	mv -- "$(git rev-parse --show-cdup)$tmpfile" "$3"
>      fi
>  }

Looking at the above change together with this disabled patch in the previous,

> +# We can't merge files from parent directories when running mergetool
> +# from a subdir. Is this a bug?
> +#
> +#test_expect_failure 'mergetool in subdir' '
> +#    cd subdir && (
> +#    ( yes "" | git mergetool ../file1 >/dev/null 2>&1 ) &&
> +#    ( yes "" | git mergetool ../file2 >/dev/null 2>&1 ) &&
> +#    test "$(cat ../file1)" = "master updated" &&
> +#    test "$(cat ../file2)" = "master new" &&
> +#    git commit -m "branch1 resolved with mergetool - subdir" )
> +#'

I wonder if it would be cleaner to keep $prefix and instead cd_to_toplevel
at the beginning.

There are two ways for Porcelain scripts to work from inside a
subdirectory of a project.

 * Stay in the original subdirectory and use show-cdup to convert a path
   that is relative to the repository root to a path relative to your
   current subdirectory.

 * Go up to the root of the work tree, use prefix to convert a path that
   is relative to the original subdirectory to a path relative to the root
   of the work tree.

The former way is probably the clunkier one between the two.  I think the
latter is how most of the Porcelain scripts work when they need to worry
about the Plumbing commands that return/accept repository relative paths.
Also, all the plumbing commands work in the latter way.
