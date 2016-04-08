From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] rev-parse: fix --git-common-dir when executed from
 subpath of main tree
Date: Fri, 8 Apr 2016 18:47:12 +0700
Message-ID: <CACsJy8CgNy8+s0j+UUVVDk1ru702mtkTrO6QsYNpisGY-eAYGw@mail.gmail.com>
References: <1459734143-95832-1-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 13:47:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoUtF-0004Sc-G8
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 13:47:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757925AbcDHLro (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 07:47:44 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:33699 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110AbcDHLrn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 07:47:43 -0400
Received: by mail-lb0-f175.google.com with SMTP id u8so67754457lbk.0
        for <git@vger.kernel.org>; Fri, 08 Apr 2016 04:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TN/fukjcoW0lNh/F4qJwZANzvGCzNiPkltROi7SXTdc=;
        b=Z49dgOMqFN6kgm/uVRcsjuRvJqlGkivGIQ5kTPqELiDhPNC+dT1VYbR0Nk4UzEG1XZ
         tfiaJpVm8Y3lCVFsMWFLuq3/g1OvXn/SJXw26JKXglG9sHo1HyRqwkIBiyQsH7BcqUUZ
         pwEuTFJPyFCdJsR9YSe60ALwLknr6z6UbdNard5z79kaxYG8z7Dhi3VC7fdeiLkg4849
         zKrtoCUVSeABAldegH8Ymf3Y5xvRUMH1alAB28d9wBbOPcFl2lwwg1D+RDoFAf3TQxdd
         Vm39SAAd5Bo10G9+8j+EJvYq0FyRnev59jVEYmssj9I/p2LkrmNGcBwEB9wQNwCJXAM8
         S+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TN/fukjcoW0lNh/F4qJwZANzvGCzNiPkltROi7SXTdc=;
        b=FncZZKB2h4ocuada4yaRfssV2o3FGOGg8uKuAa7g++4lYD9eTJ+uOupOIPUxwt8pcs
         gXgP5aERv6hIRb5KckjPw5dTdIhGty4YepD3LMDREYkAORtKJLfrRQDi0BFSuIjsXdvw
         3/OK0DRhlvT6JqZD1cv5npPya8SJU/UKZArYbzw6A5/VZqzoBuCTuXPoTmEb+YOU+I7e
         hOQ6oNd3D80haNm9uEqPX8Tm45zaQZa6Fu5zoGKA90HH7ZaR7ThBep2EolEKn3LGdCsB
         V6Nec1yCNnsrjnzmtd4BL20D/UVW6xXlFJijTWlHQNxQXcu43/0lOeP/zoZwTqd0TO5Y
         YEzQ==
X-Gm-Message-State: AD7BkJIyXNDE4HOJsblhE7DoXn/byke8ok6t8UEy7RuZ7ni2FRxhym99jsy52UTMS8GPg0dMPm4AMEixzggNoA==
X-Received: by 10.112.56.43 with SMTP id x11mr3436528lbp.145.1460116061922;
 Fri, 08 Apr 2016 04:47:41 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Fri, 8 Apr 2016 04:47:12 -0700 (PDT)
In-Reply-To: <1459734143-95832-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291029>

On Mon, Apr 4, 2016 at 8:42 AM, Michael Rappazzo <rappazzo@gmail.com> wrote:
> Executing `git-rev-parse --git-common-dir` from the root of the main
> worktree results in '.git', which is the relative path to the git dir.
> When executed from a subpath of the main tree it returned somthing like:
> 'sub/path/.git'.  Change this to return the proper relative path to the
> git directory (similar to `--show-cdup`).

I faced a similar problem just a couple days ago, I expected "git
rev-parse --git-path" to return a path relative to cwd too, but it
returned relative to git dir. The same solution (or Eric's, which is
cleaner in my opinion) applies. --shared-index-path also does
puts(git_path(... and has the same problem. Do you want to fix them
too?
-- 
Duy
