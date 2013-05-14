From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [PATCH v3 04/10] remote-hg: add new get_config_bool() helper
Date: Tue, 14 May 2013 15:18:52 -0500
Message-ID: <51929c2c85701_13a8f89e181716@nysa.mail>
References: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
 <1368486720-2716-5-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 22:20:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcLiM-0005UC-Bh
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 22:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758264Ab3ENUUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 16:20:46 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:56188 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755376Ab3ENUUp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 16:20:45 -0400
Received: by mail-oa0-f42.google.com with SMTP id i10so1229146oag.1
        for <git@vger.kernel.org>; Tue, 14 May 2013 13:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:message-id:in-reply-to:references
         :subject:mime-version:content-type:content-transfer-encoding;
        bh=o9eE3rBPEjTsQzZdgRIsBFBc4SPNGF67B135J+HrciE=;
        b=T51A1u+jIStCHoBU5Sj29zFZe2+ApVIyenARz+10J7eWWIo6sDnnipMdSIehwBTAhB
         aAugBDoviEqTRknYtbTWnRqYLOtyUxkmnOcDFxsXBCZnvUaKb9eUSYG7y5sT0hJaMDSC
         8/K0HsYvj9CXIgskQMCQzaWtWZxeLcAiiPAIXoIFlAYwouA8MhlKuKMQEaPmVmKEBeRN
         KPC98MMkvhaMGjfarUkPtnVQYhKFxQYeQBkwSQWy6PzEM9dJohXaHJjqnM7hC74Vc2Vs
         SqiPBKE0pKOr4arP0SgubpiFZGPs3nrIwZtZ11/kuPpY2b3jAsEZ7LRCoxC+nbp3Jm6Z
         XrYA==
X-Received: by 10.182.237.77 with SMTP id va13mr15649733obc.65.1368562845503;
        Tue, 14 May 2013 13:20:45 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id nt17sm23071069obb.13.2013.05.14.13.20.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 May 2013 13:20:44 -0700 (PDT)
In-Reply-To: <1368486720-2716-5-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224336>

This is simply refactoring code, functionally they are the same.

Felipe Contreras wrote:
> No functional changes.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/remote-helpers/git-remote-hg | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
> index de3a96e..4a5c72f 100755
> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -87,6 +87,15 @@ def get_config(config):
>      output, _ = process.communicate()
>      return output
>  
> +def get_config_bool(config, default=False):
> +    value = get_config(config).rstrip('\n')
> +    if value == "true":
> +        return True
> +    elif value == "false":
> +        return False
> +    else:
> +        return default
> +
>  class Marks:
>  
>      def __init__(self, path):
> @@ -327,7 +336,7 @@ def get_repo(url, alias):
>      myui.setconfig('ui', 'interactive', 'off')
>      myui.fout = sys.stderr
>  
> -    if get_config('remote-hg.insecure') == 'true\n':
> +    if get_config_bool('remote-hg.insecure'):
>          myui.setconfig('web', 'cacerts', '')
>  
>      try:
> @@ -903,16 +912,9 @@ def main(args):
>      url = args[2]
>      peer = None
>  
> -    hg_git_compat = False
> -    track_branches = True
> -    force_push = True
> -
> -    if get_config('remote-hg.hg-git-compat') == 'true\n':
> -        hg_git_compat = True
> -    if get_config('remote-hg.track-branches') == 'false\n':
> -        track_branches = False
> -    if get_config('remote-hg.force-push') == 'false\n':
> -        force_push = False
> +    hg_git_compat = get_config_bool('remote-hg.hg-git-compat')
> +    track_branches = get_config_bool('remote-hg.track-branches', True)
> +    force_push = get_config_bool('remote-hg.force-push', True)
>  
>      if hg_git_compat:
>          mode = 'hg'
> -- 
> 1.8.3.rc1.579.g184e698



-- 
Felipe Contreras
