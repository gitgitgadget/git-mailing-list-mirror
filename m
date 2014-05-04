From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/4] remote-hg: add more tests
Date: Sun, 4 May 2014 05:40:05 -0400
Message-ID: <CAPig+cSP+M_HDaif+Xy-x2tuNcjtemmugSQK2V-jKxup-Nizxw@mail.gmail.com>
References: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
	<1399169814-20201-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 04 11:40:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wgsu9-0004G0-Ps
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 11:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753386AbaEDJkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2014 05:40:07 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:64860 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753175AbaEDJkG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2014 05:40:06 -0400
Received: by mail-yk0-f172.google.com with SMTP id 131so5303363ykp.17
        for <git@vger.kernel.org>; Sun, 04 May 2014 02:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=CL3pkv4tZCDnRY7LOL7IG0uDbNtQGarD1lOFhlnRjl0=;
        b=WNpoyjI15VIa9Bm8mHuAjZc0PGMdK6XBIML7gX59kS96n0LM0YsQ1CNMmrIk5oB4MD
         5lMcrSHXm/Ao3WIU24EfjP0ZRJF5qvwvacDrlcgYRhqgbH1Ajnihf3eYrfKtngzrqhw1
         2bjMoXNanuyqv+6sS5PRdrG3iiYsSflJUIhIZvsj3xv4KjiPw6hHlNKwIfYvrMi1epAR
         3IefBheu0T4rDr3Z197BzgHB1YrWZkJMVESugvPFlR0obSe/znJTjMlhED5bVo1+vNlx
         48JHbCnTYXS9bIPND2zdrHTRuFwSHeOVkLaTJQRQOWyPVJCiYWk38/JI2grGvpTTqS+l
         jgLA==
X-Received: by 10.236.170.37 with SMTP id o25mr38151152yhl.145.1399196405613;
 Sun, 04 May 2014 02:40:05 -0700 (PDT)
Received: by 10.170.169.65 with HTTP; Sun, 4 May 2014 02:40:05 -0700 (PDT)
In-Reply-To: <1399169814-20201-2-git-send-email-felipe.contreras@gmail.com>
X-Google-Sender-Auth: 13fVS9A5QMGvsFCeWUA-TLFwKVM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248086>

On Sat, May 3, 2014 at 10:16 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Inspired by the tests in gitifyhg.
>
> One test is failing, but that's because of a limitation of
> remote-helpers.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/remote-helpers/test-hg.sh | 150 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 150 insertions(+)
>
> diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
> index 7d90056..33a434d 100755
> --- a/contrib/remote-helpers/test-hg.sh
> +++ b/contrib/remote-helpers/test-hg.sh
> @@ -845,4 +845,154 @@ test_expect_success 'clone remote with generic null bookmark, then push to the b
>         )
>  '
>
> +test_expect_success 'notes' '
> +       test_when_finished "rm -rf hgrepo gitrepo" &&
> +
> +       (
> +       hg init hgrepo &&
> +       cd hgrepo &&
> +       echo one > content &&
> +       hg add content &&
> +       hg commit -m one &&
> +       echo two > content &&
> +       hg commit -m two
> +       ) &&
> +
> +       git clone "hg::hgrepo" gitrepo &&
> +       hg -R hgrepo log --template "{node}\n\n" > expected &&
> +       git --git-dir=gitrepo/.git log --pretty="tformat:%N" --notes=hg > actual &&
> +       test_cmp expected actual
> +'
> +
> +test_expect_failure 'push updates notes' '
> +       test_when_finished "rm -rf hgrepo gitrepo" &&
> +
> +       (
> +       hg init hgrepo &&
> +       cd hgrepo &&
> +       echo one > content &&
> +       hg add content &&
> +       hg commit -m one
> +       ) &&
> +
> +       git clone "hg::hgrepo" gitrepo &&
> +
> +       (
> +       cd gitrepo &&
> +       echo two > content &&
> +       git commit -a -m two
> +       git push
> +       ) &&
> +
> +       hg -R hgrepo log --template "{node}\n\n" > expected &&
> +       git --git-dir=gitrepo/.git log --pretty="tformat:%N" --notes=hg > actual &&
> +       test_cmp expected actual
> +'
> +
> +test_expect_success 'pull tags' '
> +       test_when_finished "rm -rf hgrepo gitrepo" &&
> +
> +       (
> +       hg init hgrepo &&
> +       cd hgrepo &&
> +       echo one > content &&
> +       hg add content &&
> +       hg commit -m one
> +       ) &&
> +
> +       git clone "hg::hgrepo" gitrepo &&
> +
> +       (cd hgrepo && hg tag v1.0) &&
> +       (cd gitrepo && git pull) &&
> +
> +       echo "v1.0" > expected &&
> +       git --git-dir=gitrepo/.git tag > actual &&
> +       test_cmp expected actual
> +'
> +
> +test_expect_success 'push merged named branch' '
> +       test_when_finished "rm -rf hgrepo gitrepo" &&
> +
> +       (
> +       hg init hgrepo &&
> +       cd hgrepo &&
> +       echo one > content &&
> +       hg add content &&
> +       hg commit -m one &&
> +       hg branch feature &&
> +       echo two > content &&
> +       hg commit -m two &&
> +       hg update default &&
> +       echo three > content &&
> +       hg commit -m three
> +       ) &&
> +
> +       (
> +       git clone "hg::hgrepo" gitrepo &&
> +       cd gitrepo &&
> +       git merge -m Merge -Xtheirs origin/branches/feature &&
> +       git push
> +       ) &&
> +
> +       cat > expected <<-EOF

Broken &&-chain.

> +       Merge
> +       three
> +       two
> +       one
> +       EOF
> +       hg -R hgrepo log --template "{desc}\n" > actual &&
> +       test_cmp expected actual
> +'
> +
> +test_expect_success 'light tag sets author' '
> +       test_when_finished "rm -rf hgrepo gitrepo" &&
> +
> +       (
> +       hg init hgrepo &&
> +       cd hgrepo &&
> +       echo one > content &&
> +       hg add content &&
> +       hg commit -m one
> +       ) &&
> +
> +       (
> +       git clone "hg::hgrepo" gitrepo &&
> +       cd gitrepo &&
> +       git tag v1.0 &&
> +       git push --tags
> +       ) &&
> +
> +       echo "C O Mitter <committer@example.com>" > expected &&
> +       hg -R hgrepo log --template "{author}\n" -r tip > actual &&
> +       test_cmp expected actual
> +'
> +
> +test_expect_success 'push tag different branch' '
> +       test_when_finished "rm -rf hgrepo gitrepo" &&
> +
> +       (
> +       hg init hgrepo &&
> +       cd hgrepo &&
> +       echo one > content &&
> +       hg add content &&
> +       hg commit -m one
> +       hg branch feature &&
> +       echo two > content &&
> +       hg commit -m two
> +       ) &&
> +
> +       (
> +       git clone "hg::hgrepo" gitrepo &&
> +       cd gitrepo &&
> +       git branch &&
> +       git checkout branches/feature &&
> +       git tag v1.0 &&
> +       git push --tags
> +       ) &&
> +
> +       echo feature > expected &&
> +       hg -R hgrepo log --template="{branch}\n" -r tip > actual &&
> +       test_cmp expected actual
> +'
> +
>  test_done
> --
> 1.9.2+fc1.20.g204a630
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
