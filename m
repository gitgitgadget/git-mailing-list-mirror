From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 2/2] p4merge: create a virtual base if none available
Date: Wed, 6 Mar 2013 18:23:02 -0800
Message-ID: <CAJDDKr6+VRnc-HK52woHHLtAqXau=76Gc+Ag=keiMGffuco64A@mail.gmail.com>
References: <1362601978-16911-1-git-send-email-kevin@bracey.fi>
	<1362601978-16911-3-git-send-email-kevin@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ciaran Jessup <ciaranj@gmail.com>,
	Scott Chacon <schacon@gmail.com>
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Thu Mar 07 03:23:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDQUW-0006tN-Qw
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 03:23:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754367Ab3CGCXG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 21:23:06 -0500
Received: from mail-ee0-f50.google.com ([74.125.83.50]:60957 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350Ab3CGCXF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 21:23:05 -0500
Received: by mail-ee0-f50.google.com with SMTP id e51so6373479eek.37
        for <git@vger.kernel.org>; Wed, 06 Mar 2013 18:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=WrkaNdCimHRdFRCzJ/2jbxhFRufd7QwAMRnlT1FmyaI=;
        b=u3zRf6mTb9LNJakvBS3uMcL9W5R71xKkluRuKnblwgpg8EqN+tOZ9ZJMvCRIwt/GhH
         TQ44lRb/MfFV0+45nhhOp4LnJzPy0IkFINfddL4aijY+onmGPSP1N41qQHGJpdX3epno
         3TGcVYCzMCqjwueNLlIXTbpsIP0JqImi6+NzzseQrFkqzMtA+5dloTGoWJgt7ahPCq1D
         QNZ5kT5Z/tjW2jE9dhUNhVtmwIOBTu1S7mMbRsgkeZTkrCqHse8WMFsCz5if50YlfN1D
         gzgKLNEgw4wKIg52n/TdzmxnTz+S4hnsH2cTzpuKJdoaFNGQV7guB7myxrFM164FFwZL
         xOJQ==
X-Received: by 10.15.67.134 with SMTP id u6mr86773128eex.6.1362622983021; Wed,
 06 Mar 2013 18:23:03 -0800 (PST)
Received: by 10.14.194.3 with HTTP; Wed, 6 Mar 2013 18:23:02 -0800 (PST)
In-Reply-To: <1362601978-16911-3-git-send-email-kevin@bracey.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217570>

On Wed, Mar 6, 2013 at 12:32 PM, Kevin Bracey <kevin@bracey.fi> wrote:
> Originally, with no base, Git gave P4Merge $LOCAL as a dummy base:
>
>    p4merge "$LOCAL" "$LOCAL" "$REMOTE" "$MERGED"
>
> Commit 0a0ec7bd changed this to:
>
>    p4merge "empty file" "$LOCAL" "$REMOTE" "$MERGED"
>
> to avoid the problem of being unable to save in some circumstances.
>
> Unfortunately this approach does not produce good results at all on
> differing inputs. P4Merge really regards the blank file as the base, and
> once you have just a couple of differences between the two branches you
> end up with one a massive full-file conflict. The diff is not readable,
> and you have to invoke "difftool MERGE_HEAD HEAD" manually to see a
> 2-way diff.
>
> The original form appears to have invoked special 2-way comparison
> behaviour that occurs only if the base filename is "" or equal to the
> left input.  You get a good diff, and it does not auto-resolve in one
> direction or the other. (Normally if one branch equals the base, it
> would autoresolve to the other branch).
>
> But there appears to be no way of getting this 2-way behaviour and being
> able to reliably save. Having base=left appears to be triggering other
> assumptions. There are tricks the user can use to force the save icon
> on, but it's not intuitive.
>
> So we now follow a suggestion given in the original patch's discussion:
> generate a virtual base, consisting of the lines common to the two
> branches. It produces a much nicer 3-way diff view than either of the
> original forms, and than I suspect other mergetools are managing.
>
> Signed-off-by: Kevin Bracey <kevin@bracey.fi>
> ---
>  git-mergetool--lib.sh | 14 ++++++++++++++
>  mergetools/p4merge    |  2 +-
>  2 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index e338be5..5b60cf5 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -108,6 +108,20 @@ check_unchanged () {
>         fi
>  }
>
> +make_virtual_base() {
> +               # Copied from git-merge-one-file.sh.

I think the reasoning behind these patches is good.

How do we feel about this duplication?
Should we make a common function in the git-sh-setup.sh,
or is it okay to have a slightly modified version of this
function in two places?

> +               # This starts with $LOCAL, and uses git apply to
> +               # remove lines that are not in $REMOTE.
> +               cp -- "$LOCAL" "$BASE"
> +               sz0=`wc -c <"$BASE"`
> +               @@DIFF@@ -u -L"a/$BASE" -L"b/$BASE" "$BASE" "$REMOTE" | git apply --no-add
> +               sz1=`wc -c <"$BASE"`
> +
> +               # If we do not have enough common material, it is not
> +               # worth trying two-file merge using common subsections.
> +               expr $sz0 \< $sz1 \* 2 >/dev/null || : >"$BASE"
> +}
> +
>  valid_tool () {
>         setup_tool "$1" && return 0
>         cmd=$(get_merge_tool_cmd "$1")
> diff --git a/mergetools/p4merge b/mergetools/p4merge
> index 46b3a5a..f0a893b 100644
> --- a/mergetools/p4merge
> +++ b/mergetools/p4merge
> @@ -21,7 +21,7 @@ diff_cmd () {
>
>  merge_cmd () {
>         touch "$BACKUP"
> -       $base_present || >"$BASE"
> +       $base_present || make_virtual_base
>         "$merge_tool_path" "$BASE" "$REMOTE" "$LOCAL" "$MERGED"
>         check_unchanged
>  }
> --
> 1.8.2.rc2.5.g1a80410.dirty
>



-- 
David
