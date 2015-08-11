From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] worktree: add 'list' command
Date: Tue, 11 Aug 2015 08:46:20 -0700
Message-ID: <xmqq37zpu8tv.fsf@gitster.dls.corp.google.com>
References: <1439239982-42826-1-git-send-email-rappazzo@gmail.com>
	<1439239982-42826-2-git-send-email-rappazzo@gmail.com>
	<xmqqr3nau74h.fsf@gitster.dls.corp.google.com>
	<CANoM8SWeqxD2vWLQmEfxxxn8Dz4yPfjGOoOH=Azn1A3So+wz2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Mike Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 17:46:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPBkx-00005N-Hc
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 17:46:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965205AbbHKPqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 11:46:23 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:32871 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965045AbbHKPqW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 11:46:22 -0400
Received: by pdrh1 with SMTP id h1so66885797pdr.0
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 08:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=9OR7d0tALbQuC63LKQsdEDJycmRvlXkQIHJl/FXN8+0=;
        b=pt/F0hvO8moJ4M35VhADdHwj/qZ9nYXD0VpVjMaQCbs4vo/5hYONPeulz7VaTqU1H/
         EY8zwTFFm6gL0lhTIqX8pxggGyxtoZfNHAVO7DQdKab0OU1pKJhz5M+ANNuz6ttnQYVb
         Yxu0ggremODH0fkCPJ5rzVW61WX1TnRX+mn9VIMrh0qYVwGkmiEAwSK7b3cRbk56tt1M
         nzHuorNWPm8dM++nxOxhUKvcvwlUM3tPdQwtDgEsPFUIvj5d5mUpdXB6Zeew5eq2bENn
         cbm3Y1OOknN+rTy/nTtKK3cyuhxHf/dDPpZ8IqfFw18Eazs7Cw/+fbKqvM7Dk2VqUUVh
         fWyg==
X-Received: by 10.70.43.198 with SMTP id y6mr12782014pdl.4.1439307982100;
        Tue, 11 Aug 2015 08:46:22 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:894d:5945:d51a:995b])
        by smtp.gmail.com with ESMTPSA id g10sm3135866pat.35.2015.08.11.08.46.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 11 Aug 2015 08:46:21 -0700 (PDT)
In-Reply-To: <CANoM8SWeqxD2vWLQmEfxxxn8Dz4yPfjGOoOH=Azn1A3So+wz2Q@mail.gmail.com>
	(Mike Rappazzo's message of "Tue, 11 Aug 2015 07:41:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275693>

Mike Rappazzo <rappazzo@gmail.com> writes:

>>> +     int is_bare = is_bare_repository();
>>
>> Please do not introduce decl-after-stmt.
>
> Since I reused this value below, I thought it would be acceptable.

Use of a new variable is fine.  "Do not declare one in a block after
you already wrote statement" is what "decl-after-stmt not allowed"
means.  In your patch:

+static int list(int ac, const char **av, const char *prefix)
+{
+	int main_only = 0;
+	struct option options[] = {
+		OPT_BOOL(0, "main-only", &main_only, N_("only list the main worktree")),
+		OPT_END()
+	};
+
+	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
+	if (ac)
+		usage_with_options(worktree_usage, options);
+
+	struct strbuf main_path = STRBUF_INIT;
+	const char* common_dir = get_git_common_dir();
+	int is_bare = is_bare_repository();

Three variables, main_path, common_dir and is_bare are declared here
after statements such as a call to parse_options().  Don't.

+static int list(int ac, const char **av, const char *prefix)
+{
+	int main_only = 0;
+	struct strbuf main_path = STRBUF_INIT;
+	const char *common_dir;
+	int is_bare;
+	struct option options[] = {
+		OPT_BOOL(0, "main-only", &main_only, N_("only list the main worktree")),
+		OPT_END()
+	};
+
+	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
+	if (ac)
+		usage_with_options(worktree_usage, options);
+
+	common_dir = get_git_common_dir();
+	int is_bare = is_bare_repository();
