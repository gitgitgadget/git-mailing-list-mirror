From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH RFC] add: Do not open editor if patch is empty
Date: Sun, 26 Apr 2015 14:39:06 -0400
Message-ID: <CAPig+cTMWe4gnuMrx-aP1Zu+qr6UqmHFmJj2JoahtuxcDGLTQg@mail.gmail.com>
References: <1430067820-3349-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 26 20:39:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmRSS-00020V-3R
	for gcvg-git-2@plane.gmane.org; Sun, 26 Apr 2015 20:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbbDZSjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2015 14:39:08 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:33890 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbbDZSjH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2015 14:39:07 -0400
Received: by iedfl3 with SMTP id fl3so128196195ied.1
        for <git@vger.kernel.org>; Sun, 26 Apr 2015 11:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=es6GtpUCqluYYSggYM61CiPcUMNTe9obWiogp2lB92U=;
        b=H9eFm/jVrRLCzMtKaBaS6zampBKikN5Y78K/vrhFumrvOS2sRC/FLAXRToAQk2IK24
         GTKAXSIGLOTBB7cd9p7Ni4U86myN2vNyPtQ1DDyqGPVoJadGpvo876eIPBdjGGsvLiu+
         wPRyuMgcvWpaxz0IE0Qw+jRRNeL+4F1HqY3lOpW2lTo3JNq0zR6TnQ+gDn9RjXVZmGkf
         Nr4IGhZiwRnzfooUgq2aV7qeQ7NfoA6T+72bWH4eNYxOsnQEBNED2XWhmDWLhxccBm5I
         eacw16IJmGMUcWez/Eu2Ku+w2SpugAt1+sKqMGPw4cHXCDFZDzadkpjsa4cUt8SQxByD
         60Tg==
X-Received: by 10.50.27.67 with SMTP id r3mr9053186igg.15.1430073546345; Sun,
 26 Apr 2015 11:39:06 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Sun, 26 Apr 2015 11:39:06 -0700 (PDT)
In-Reply-To: <1430067820-3349-1-git-send-email-kuleshovmail@gmail.com>
X-Google-Sender-Auth: KPcIpoG3iZggZTThJ588IPLqQQ8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267832>

On Sun, Apr 26, 2015 at 1:03 PM, Alexander Kuleshov
<kuleshovmail@gmail.com> wrote:
> If we'll run 'git add -e <path>' on a path which has no
> difference with the current index, empty editor will open. This
> patch prevents this behaviour and checks that patch is not empty
> before an editor with patch will be opened.
>
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---
> diff --git a/builtin/add.c b/builtin/add.c
> index ee370b0..4fc6b13 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -209,13 +209,13 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
>         if (run_diff_files(&rev, 0))
>                 die(_("Could not write patch"));
>
> -       launch_editor(file, NULL, NULL);
> -
>         if (stat(file, &st))
>                 die_errno(_("Could not stat '%s'"), file);
>         if (!st.st_size)
>                 die(_("Empty patch. Aborted."));
>
> +       launch_editor(file, NULL, NULL);

But this breaks intended behavior[1] in which "git add -e" aborts with
message "Empty patch" if the user deletes everything from the patch
file in the editor.

[1]: c59cb03 (git-add: introduce --edit (to edit the diff vs. the
index), 2009-04-08)

>         child.git_cmd = 1;
>         child.argv = apply_argv;
>         if (run_command(&child))
> --
> 2.3.3.611.g09038fc.dirty
