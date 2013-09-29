From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 02/44] ruby: add support for internal ruby programs
Date: Sun, 29 Sep 2013 10:10:49 +0530
Message-ID: <CALkWK0=XSxiz+MoU2H7Zxo4gSRvs+C5fGpnD2ioBvrXzdLpmww@mail.gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com> <1380405849-13000-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 29 06:41:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ8pH-0004Sh-Oe
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 06:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073Ab3I2Elb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Sep 2013 00:41:31 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:35163 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890Ab3I2Ela (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Sep 2013 00:41:30 -0400
Received: by mail-ie0-f171.google.com with SMTP id at1so7431765iec.16
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 21:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=TioJotf8euxXBqrgAR0SfIqy+KuSVCMHDq9lPGqCSm8=;
        b=NOvUWSAjptUDuWBEeEM5DAlV6bPRwVM1J45IbeyKHfR0Hf0TewpVjX21uuwko8meEJ
         YK3k69mqaY+QoCS6PVaG06iC/6M34sXI5wFvr+SnVUMI/Y0jftdwcVhpUpvmzqNrh9aa
         qYpIi+i3q31AoZqSxOcjSpo6N4qJWzaf3hyUVgSONFdaPmoK1niEpVrK4WSYHeXWQ17I
         tujFKLXoks20kXszjHKGmBA1KPMhJMMDnv/wMX9DnY+RU38/+vA8t9IDYC8/Vby4xiQg
         SAHKKWIoRzmgaOv1p6Np7v/k/BybNrn/nEl5p0Lf9EXzf1STANmLUsVVVZPF/41EdK1S
         l2EA==
X-Received: by 10.42.250.148 with SMTP id mo20mr11793480icb.34.1380429689691;
 Sat, 28 Sep 2013 21:41:29 -0700 (PDT)
Received: by 10.64.73.36 with HTTP; Sat, 28 Sep 2013 21:40:49 -0700 (PDT)
In-Reply-To: <1380405849-13000-3-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235581>

Felipe Contreras wrote:
> +$(RUBY_PROGRAMS): git-ruby$X
> +       $(QUIET_BUILT_IN)$(RM) $@ && \
> +       ln >lt; $@ 2>/dev/null || \
> +       ln -s >lt; $@ 2>/dev/null || \
> +       cp >lt; $@

Why so many fallbacks? Will the hard-link (the first ln) ever fail?

> diff --git a/ruby.c b/ruby.c
> index ee6a0e7..339e376 100644
> --- a/ruby.c
> +++ b/ruby.c
> @@ -52,5 +52,22 @@ static int run_ruby_command(const char *cmd, int argc, const char **argv)
>
>  int main(int argc, const char **argv)
>  {
> -       return run_ruby_command(argv[1], argc, argv);
> +       if (!strcmp(argv[0], "git-ruby")) {
> +               return run_ruby_command(argv[1], argc, argv);
> +       } else {
> +               const char *cmd = argv[0];
> +               static char buf[PATH_MAX + 1];
> +               const char *args[argc + 1];
> +               int i;
> +
> +               snprintf(buf, PATH_MAX, "%s/%s.rb",
> +                               git_exec_path(), basename((char *)cmd));
> +
> +               args[0] = "git";
> +               args[1] = buf;
> +               for (i = 0; i < argc - 1; i++)
> +                       args[i + 2] = (char *)argv[i + 1];
> +
> +               return run_ruby_command(cmd, argc + 1, args);
> +       }
>  }

Can you explain this in greater detail in your commit message? When I
pass an argument,

  $ git ruby foo
  git-ruby: No such file or directory -- foo (LoadError)

I get this as before. How exactly will new ruby scripts be executed?
(I can only guess at this point)
