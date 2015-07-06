From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 23/23] checkout: retire --ignore-other-worktrees in favor of --force
Date: Mon, 06 Jul 2015 12:40:32 -0700
Message-ID: <xmqqlhetyszz.fsf@gitster.dls.corp.google.com>
References: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
	<1436203860-846-24-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 21:40:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCCFr-0008BL-RP
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 21:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755121AbbGFTkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 15:40:35 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:33097 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755133AbbGFTke (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 15:40:34 -0400
Received: by igh16 with SMTP id 16so34045525igh.0
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 12:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=APJcIKF7vKL4CDsJtFaAz54gvXgopaXRYlHW50npStE=;
        b=GbrE8WpwIGpw/TQlRkaMFsSC3z6iGd75ouM1Zb+m42Fa5Xi8Okg2gt6822xwH5Kei1
         EFfttTgWlf4v9ess8BzrpbfedoGd5ehjJj2z2SuS5NE0QNAu6rt5nwwwdOfLLK/PLWW/
         74MuuruwC8WXiW94u+K7Xj98G4qb2GsAen19RqYUV9BIhs4L3csSnbAoUR3Btlh2u18x
         VZjVEosZ3734744PF3p1BC/sZ67j7S0HH4UYVb843GDlZNAGLCqhK11Yz7QT9YTsi1Co
         SXXIk8DIWW2sIXeZluhdWP7hcfJ8ZWIcPejnKIrHGjzRudXf6aQzxbtJxM741Egl1TEw
         ylfg==
X-Received: by 10.50.18.39 with SMTP id t7mr43387406igd.3.1436211633682;
        Mon, 06 Jul 2015 12:40:33 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ad70:2147:d1ba:ffd8])
        by smtp.gmail.com with ESMTPSA id bf10sm10293691igb.12.2015.07.06.12.40.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jul 2015 12:40:33 -0700 (PDT)
In-Reply-To: <1436203860-846-24-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Mon, 6 Jul 2015 13:31:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273453>

Eric Sunshine <sunshine@sunshineco.com> writes:

> As a safeguard, checking out a branch already checked out by a different
> worktree is disallowed. This behavior can be overridden with
> --ignore-other-worktrees, however, this option is neither obvious nor
> particularly discoverable. As a common safeguard override, --force is
> more likely to come to mind. Therefore, overload it to also suppress the
> check for a branch already checked out elsewhere.

I hate to be asking this again but why is it a good idea to allow
'ignore-other-worktrees' in the first place (let alone making it
more discoverable)?  You'll have multiple working trees, either
using the new "git worktree" or using the old contrib/workdir, for
one of the two reasons:

 * You need a separate work area to build a new history.

 * You need a separate work area to expand the contents of a
   specific commit.

Here "create binary by running make" falls into the latter category;
as far as Git is concerned, you are only looking at, not extending
the history of any specific branch.

If you are extending the history of some branch, then you would want
to be on that branch.  Why would you want to have another worktree
that will get into a confusing state once you create that commit on
the checked out branch in this newly created worktree?

Wasn't the whole point of making the primary repository aware of the
secondary worktrees via the "linked checkout" mechanism because that
confusion was the biggest sore point of the old contrib/workdir
implementation?
