From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 03/16] index-helper: new daemon for caching index and
 related stuff
Date: Fri, 8 Apr 2016 18:26:38 +0700
Message-ID: <CACsJy8C5NhaAAW=wzpwkBdLvVZz8wVM7QX==n_CL5g+LLAKY=A@mail.gmail.com>
References: <1459980722-4836-1-git-send-email-dturner@twopensource.com> <1459980722-4836-4-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, aevarb@gmail.com,
	jeffhost@microsoft.com
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 13:27:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoUZK-0000gj-7F
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 13:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758043AbcDHL1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 07:27:11 -0400
Received: from mail-lb0-f195.google.com ([209.85.217.195]:33335 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757920AbcDHL1J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 07:27:09 -0400
Received: by mail-lb0-f195.google.com with SMTP id ot1so2764794lbb.0
        for <git@vger.kernel.org>; Fri, 08 Apr 2016 04:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wQ7yY8y6KX6Nbvj+5GBUh30aWglILKxSA14G0gf/xWQ=;
        b=vwaqniUphYNmVQNrhlOIC7pXL+BjrlgdRyeGOjgTLK9LOW75tio0/+dsa9aBeUhspU
         irUniF2mQtOIBLc35HYgTa9YQLLYZdREdN+5bKQY9b7Oi3QQW8wQZh0qXcvxo5GQ3AZA
         HcV/+rOzpvDJIFpABWDuVzq0bbE0YdqS5u3vgRmr7Pn/u/5hCd30aDaPI/4y6sgjiGKl
         8GltuXkBQ7t85EAn2r+9fJlFanO/RBpVuLCjggM3jAE1+8aZjWC4aH1C9VgtdemXau4c
         Q3qIQGo+UsQu/ZNFuLSKuKsiuussks5MQHWS/FtXw0IXGg1jHwpgN7b2siddYVvP5bLA
         Jv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wQ7yY8y6KX6Nbvj+5GBUh30aWglILKxSA14G0gf/xWQ=;
        b=MLubK8MDRZ9j5tGo8WGv3hI/tHXVp6ev3gzxBurFbRYNVhu2JwGkB6Q3yF8mQ/IlV2
         YER4hkJWEdUjAAeAcB98iMZoA5yu95/3fVoyuKTquW8Muw12HzrAxoeKOY3XyeUZCcWB
         r/0HDqEXN84zIok3HDLy0H4GyscprKZWgGtmBQbZScduJroAWG1XJwJkRtfDGV1chp28
         sFfaBFPwnjqPmbsorrt8vmm23Y73yB8xjAEOdSP5vGBR1EHpCyrlsbKMCVjOncMV1vfe
         kbo8/2QdtoSVoaF7K+UvvEXYcVK+XFda+UAh9GnoJ4cjXMJJaP9y75NbQOmAjQwbWbf7
         5IQA==
X-Gm-Message-State: AD7BkJI/C27j+h//qknL+8JhY1ysAuAUf7g2p8Wds2JJ0o/ZUJ7mAD8vRd5v0UMH3tNXbAYZVu2k3j4PIEu0og==
X-Received: by 10.112.56.43 with SMTP id x11mr3402413lbp.145.1460114827766;
 Fri, 08 Apr 2016 04:27:07 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Fri, 8 Apr 2016 04:26:38 -0700 (PDT)
In-Reply-To: <1459980722-4836-4-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291022>

On Thu, Apr 7, 2016 at 5:11 AM, David Turner <dturner@twopensource.com> wrote:
> @@ -1045,4 +1046,21 @@ struct tm *git_gmtime_r(const time_t *, struct tm *);
>  #define getc_unlocked(fh) getc(fh)
>  #endif
>
> +#ifdef __linux__
> +#define UNIX_PATH_MAX 108
> +#elif defined(__APPLE__) || defined(BSD)
> +#define UNIX_PATH_MAX 104
> +#else
> +/*
> + * Quoth POSIX: The size of sun_path has intentionally been left
> + * undefined. This is because different implementations use different
> + * sizes. For example, 4.3 BSD uses a size of 108, and 4.4 BSD uses a
> + * size of 104. Since most implementations originate from BSD
> + * versions, the size is typically in the range 92 to 108.
> + *
> + * Thanks, POSIX!  Super-helpful!  Hope we don't overflow any buffers!
> + */
> +#define UNIX_PATH_MAX 92
> +#endif

Okay. You probably want to fix unix-socket.c too, and maybe reuse that
code instead of opening unix sockets manually. There's a check in
unix_sockaddr_init() about sizeof(sun_path) but I'm not sure if it
suffices.

BTW, it looks like you tested this on Mac. But config.mak.uname only
enables HAVE_SHM on Linux. Should it be enabled on Mac as well at
least?
--
Duy
