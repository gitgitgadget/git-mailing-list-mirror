From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/14] Make git-pull a builtin
Date: Mon, 18 May 2015 12:21:37 -0700
Message-ID: <xmqqh9r9bsji.fsf@gitster.dls.corp.google.com>
References: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 18 21:21:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuQbg-0002Mr-VA
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 21:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbbERTVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 15:21:40 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:33726 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932516AbbERTVj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 15:21:39 -0400
Received: by iebgx4 with SMTP id gx4so178969604ieb.0
        for <git@vger.kernel.org>; Mon, 18 May 2015 12:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=XP5HZEClcWvaLEkGfraMmUafuxbm+rbSerpOE2j+kks=;
        b=chaYr7PA74IraOkbo9tncobrIp4QugSji9ha5+iz4AiAlpvv9FHI6rlnA33u8Hhpk0
         aq8iOs5ptV4j+PbjpMZ89rgus/SmUz4rhd2FaKdpVOeZr2j4wc+F12V+Tnpa1kkxXJQo
         MwEmzZxu6tiE8gC1YMewrLIhRM9jViEqQwPORkyWD6ibwUB42txCRBGTjhbFwXYcAyMZ
         nbqeAlfUXond6rAPN2TOBftzZtYoxoBGUQ5MiVXYhKg3YEmyyGApqoqCBZjpSEVfjVPT
         7cqt1OKxo9jOVNZQHAiRwa0kyh53+9mF4G0UAdPG2o/+hRn4Uy+pm4i8xqZGm4PFpn41
         /Ygw==
X-Received: by 10.42.187.65 with SMTP id cv1mr37877022icb.87.1431976898721;
        Mon, 18 May 2015 12:21:38 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:2120:a5f3:f7b6:7da9])
        by mx.google.com with ESMTPSA id l1sm8290324ioe.32.2015.05.18.12.21.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 18 May 2015 12:21:38 -0700 (PDT)
In-Reply-To: <1431961571-20370-1-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Mon, 18 May 2015 23:05:57 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269311>

Paul Tan <pyokagan@gmail.com> writes:

> This series rewrites git-pull.sh into a C builtin, thus improving its
> performance and portability. It is part of my GSoC project to rewrite git-pull
> and git-am into builtins[2].

Earlier you were worried about 'git pull' being used in many tests
for the purpose of testing other parts of the system and not testing
'pull' itself.  For a program as complex as 'git pull', you may want
to take the 'competing implementations' approach.

(1) write an empty cmd_pull() that relaunches "git pull" scripted
    porcelain from the $GIT_EXEC_PATH with given parameters, and
    wire all the necessary bits to git.c.

(2) enhance cmd_pull() a bit by bit, but keep something like this

	if (getenv(GIT_USE_BUILTIN_PULL)) {
        	/* original run_command("git-pull.sh") code */
                exit $?
	}

        ... your "C" version ...

(3) add "GIT_USE_BUILTIN_PULL=Yes; export GIT_USE_BUILTIN_PULL" at
    the beginning of "t55??" test scripts (but not others that rely
    on working pull and that are not interested in catching bugs in
    pull).

(4) once cmd_pull() becomes fully operational, drop (3) and also the
    conditional one you added in (2), and retire the environment
    variable.  Retire the git-pull.sh script to contrib/examples/
    boneyard.

That way, you will always have a reference you can use throughout
the development.

Just a suggestion, not a requirement.
