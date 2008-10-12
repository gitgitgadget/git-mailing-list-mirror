From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git apply --directory broken for new files
Date: Sat, 11 Oct 2008 23:36:18 -0700
Message-ID: <7v1vymial9.fsf@gitster.siamese.dyndns.org>
References: <48DBF794.9030809@zytor.com>
 <20080927015422.GA31783@coredump.intra.peff.net>
 <7vk5ceijqo.fsf@gitster.siamese.dyndns.org>
 <20081012040611.GA11199@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 12 08:37:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KouaH-0005R1-3s
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 08:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbYJLGgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 02:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbYJLGgc
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 02:36:32 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63339 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035AbYJLGgc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 02:36:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C3CF988E1D;
	Sun, 12 Oct 2008 02:36:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 535D188E1B; Sun, 12 Oct 2008 02:36:20 -0400 (EDT)
In-Reply-To: <20081012040611.GA11199@coredump.intra.peff.net> (Jeff King's
 message of "Sun, 12 Oct 2008 00:06:11 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1A453134-9828-11DD-816E-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98003>

Jeff King <peff@peff.net> writes:

>> It would be easier to do this --directory prefixing in the sole caller of
>> git_header_name(), though.
>
> I went this route, and it is much more readable if slightly less
> efficient (one extra malloc/free).

I do not think efficiency is an issue in this codepath --- especially
because it is only triggered when --directory is in use.

Acked-by: Junio C Hamano <gitster@pobox.com>

>
> -- >8 --
> git apply --directory broken for new files
>
> We carefully verify that the input to git-apply is sane,
> including cross-checking that the filenames we see in "+++"
> headers match what was provided on the command line of "diff
> --git". When --directory is used, however, we ended up
> comparing the unadorned name to one with the prepended root,
> causing us to complain about a mismatch.
>
> We simply need to prepend the root directory, if any, when
> pulling the name out of the git header.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin-apply.c       |    7 ++++++
>  t/t4128-apply-root.sh |   52 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 59 insertions(+), 0 deletions(-)
>
> diff --git a/builtin-apply.c b/builtin-apply.c
> index bf80610..be7e1bd 100644
> --- a/builtin-apply.c
> +++ b/builtin-apply.c
> @@ -810,6 +810,13 @@ static int parse_git_header(char *line, int len, unsigned int size, struct patch
>  	 * the default name from the header.
>  	 */
>  	patch->def_name = git_header_name(line, len);
> +	if (patch->def_name && root) {
> +		char *s = xmalloc(root_len + strlen(patch->def_name) + 1);
> +		strcpy(s, root);
> +		strcpy(s + root_len, patch->def_name);
> +		free(patch->def_name);
> +		patch->def_name = s;
> +	}
>  
>  	line += len;
>  	size -= len;
> diff --git a/t/t4128-apply-root.sh b/t/t4128-apply-root.sh
> index 2dd0c75..bc7a8a8 100755
> --- a/t/t4128-apply-root.sh
> +++ b/t/t4128-apply-root.sh
> @@ -40,4 +40,56 @@ test_expect_success 'apply --directory -p (2) ' '
>  
>  '
>  
> +cat > patch << EOF
> +diff --git a/newfile b/newfile
> +new file mode 100644
> +index 0000000..d95f3ad
> +--- /dev/null
> ++++ b/newfile
> +@@ -0,0 +1 @@
> ++content
> +EOF
> +
> +test_expect_success 'apply --directory (new file)' '
> +	git reset --hard initial &&
> +	git apply --directory=some/sub/dir/ --index patch &&
> +	test content = $(git show :some/sub/dir/newfile) &&
> +	test content = $(cat some/sub/dir/newfile)
> +'
> +
> +cat > patch << EOF
> +diff --git a/delfile b/delfile
> +deleted file mode 100644
> +index d95f3ad..0000000
> +--- a/delfile
> ++++ /dev/null
> +@@ -1 +0,0 @@
> +-content
> +EOF
> +
> +test_expect_success 'apply --directory (delete file)' '
> +	git reset --hard initial &&
> +	echo content >some/sub/dir/delfile &&
> +	git add some/sub/dir/delfile &&
> +	git apply --directory=some/sub/dir/ --index patch &&
> +	! git ls-files | grep delfile
> +'
> +
> +cat > patch << 'EOF'
> +diff --git "a/qu\157tefile" "b/qu\157tefile"
> +new file mode 100644
> +index 0000000..d95f3ad
> +--- /dev/null
> ++++ "b/qu\157tefile"
> +@@ -0,0 +1 @@
> ++content
> +EOF
> +
> +test_expect_success 'apply --directory (quoted filename)' '
> +	git reset --hard initial &&
> +	git apply --directory=some/sub/dir/ --index patch &&
> +	test content = $(git show :some/sub/dir/quotefile) &&
> +	test content = $(cat some/sub/dir/quotefile)
> +'
> +
>  test_done
> -- 
> 1.6.0.2.519.g6cb82.dirty
