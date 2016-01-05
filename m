From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Add a test for subtree rebase that loses commits
Date: Tue, 5 Jan 2016 15:34:04 -0500
Message-ID: <CAPig+cSOzwGdp-FACM2=wK78KSjvEZoB6VKiEtBLnBX0G1L4QQ@mail.gmail.com>
References: <1451968805-6948-1-git-send-email-greened@obbligato.org>
	<1451968805-6948-2-git-send-email-greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>
To: David Greene <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Tue Jan 05 21:34:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGYJS-0007Q9-Pd
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 21:34:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115AbcAEUed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 15:34:33 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:34738 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbcAEUeG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 15:34:06 -0500
Received: by mail-vk0-f65.google.com with SMTP id a123so579872vkh.1
        for <git@vger.kernel.org>; Tue, 05 Jan 2016 12:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=LQQ0u2wuPGsbxjPX7xFLZjCSaqqxiPrG1f7GJ9iOFd8=;
        b=j8Poj//FkDhO4qirOfqksHoxgA4cSbzxc40K53v/uLawOe+JHPPi6Aj6e050+kLeWX
         aVyBjtwq+a3BgwqYez3ml/uMhE64LMlHdHtYIZt+sPqZeABZSrGn+KVxN5+yszlVpTfu
         J/llSbI9HDciSJH4nt8YkmsLnt5hE56G7uDw0OoRqkWucXuH9K/0gHylu7oH11gflX9Y
         pxTBm+K4jZUz8xWOWkvOYLH5+MISuzXF5m+6IHEgeT/N3Vxm9vxwI+624GqctqWJZPO/
         smiPRJt7baC4YXIVkSMpSzVp0lZNppp8VcfsDz3bykjB2iaAJsCdw0gOENSRPIg1IV81
         no5g==
X-Received: by 10.31.164.78 with SMTP id n75mr33706756vke.14.1452026045018;
 Tue, 05 Jan 2016 12:34:05 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Tue, 5 Jan 2016 12:34:04 -0800 (PST)
In-Reply-To: <1451968805-6948-2-git-send-email-greened@obbligato.org>
X-Google-Sender-Auth: zs2IoThawieiTV3_ZzfBC-Pc3wo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283398>

On Mon, Jan 4, 2016 at 11:40 PM, David Greene <greened@obbligato.org> wrote:
> This test merges an external tree in as a subtree, makes some commits
> on top of it and splits it back out.  In the process the added commits
> are lost.  This is marked to expect failure so that we don't forget to
> fix it.
>
> Signed-off-by: David A. Greene <greened@obbligato.org>
> ---
> diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
> @@ -0,0 +1,68 @@
> +#!/bin/sh
> +
> +test_description='git rebase tests for -Xsubtree
> +
> +This test runs git rebase and tests the subtree strategy.
> +'
> +. ./test-lib.sh
> +
> +addfile() {
> +    name=$1
> +    echo $(basename ${name}) > ${name}
> +    ${git} add ${name}
> +    ${git} commit -m "Add $(basename ${name})"
> +}

What is this function for? It doesn't seem to be used at all by this script.

> +check_equal()
> +{

Style: Place brace on the same line as the function declaration.

> +       test_debug 'echo'
> +       test_debug "echo \"check a:\" \"{$1}\""
> +       test_debug "echo \"      b:\" \"{$2}\""
> +       if [ "$1" = "$2" ]; then

Style: Use 'test' rather than '[', drop semi-colon, and place 'then'
on its own line.

> +               return 0
> +       else
> +               return 1
> +       fi

This entire if/else/fi can be rephrased as just a single line at the
end of the function:

    test "$1" = "$2"

the result of which will be 0 if the strings are equal, else 1, thus
there's no need for if/else/fi.

> +}

Isn't check_equal() pretty much a (less generic) re-invention of
t/test-lib-functions.sh:verbose()?

> +last_commit_message()
> +{
> +       git log --pretty=format:%s -1
> +}

Are there plans to re-use this function by more than the current
single call site? If not, it might be just as clear to assign the
result of the expression to an aptly named variable directly in the
caller:

   last_commit_msg=$(git log --pretty=format:%s -1)

or something.

> +test_expect_success 'setup' '
> +       test_commit README &&
> +       mkdir files &&
> +       cd files &&
> +       git init &&
> +       test_commit master1 &&
> +       test_commit master2 &&
> +       test_commit master3 &&
> +       cd .. &&

Mentioned by Torsten: If any command before "cd .." fails, then "cd
.." won't be invoked, and subsequent tests will be executed in the
wrong directory. Use a subshell to overcome this problem since the
current directory of the parent shell is not impacted by the subshell
(thus you can drop the "cd .." altogether):

    mkdir files &&
    (
        cd files &&
        git init &&
        ...
    ) &&
    ...

> +       test_debug "echo Add project master to master" &&
> +       git fetch files master &&
> +       git branch files-master FETCH_HEAD &&
> +       test_debug "echo Add subtree master to master via subtree" &&
> +       git read-tree --prefix=files_subtree files-master &&
> +       git checkout -- files_subtree &&
> +       tree=$(git write-tree) &&
> +       head=$(git rev-parse HEAD) &&
> +       rev=$(git rev-parse --verify files-master^0) &&
> +       commit=$(git commit-tree -p ${head} -p ${rev} -m "Add subproject master" ${tree}) &&

Nit: This could be less syntactically noisy by dropping the
unnecessary braces: ${head} -> $head

> +       git reset ${commit} &&
> +       cd files_subtree &&
> +       test_commit master4 &&
> +       cd .. &&
> +       test_commit files_subtree/master5
> +'
> +
> +# Does not preserve master4 and master5.
> +test_expect_failure 'Rebase default' '
> +       git checkout -b rebase-default master &&
> +       git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
> +       git commit -m "Empty commit" --allow-empty &&
> +       git rebase -Xsubtree=files_subtree  --preserve-merges --onto files-master master &&

Style: Too many spaces before --preserve-merges.

> +       check_equal "$(last_commit_message)" "files_subtree/master5"

Hmm, is checking the commit message the best way to determine if the
expected commit was there? Why not check the commit ID instead or
something?

> +'
> +
> +test_done
> --
> 2.6.1
