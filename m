From: Junio C Hamano <gitster@pobox.com>
Subject: Re: unexplained behavior/issue with git archive?
Date: Thu, 23 Jul 2015 10:21:12 -0700
Message-ID: <xmqqwpxqpz7b.fsf@gitster.dls.corp.google.com>
References: <55B10705.6090303@jvales.net>
	<20150723155936.GC14935@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jan Vales <jan@jvales.net>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Jul 23 19:21:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIKBL-000651-BI
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 19:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753664AbbGWRVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 13:21:16 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34538 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923AbbGWRVO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 13:21:14 -0400
Received: by pacan13 with SMTP id an13so162574684pac.1
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 10:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=QoGwTLfvCv8HOAPZ6VVnrqL4B4KVp9ZvL4RrjbqyI/8=;
        b=fsd2eQ0PPTLjZ0F34gG8p+dXnu3K3eSjZZrDBoxk5s2CWfVvSiuRdJYbpqOfBcCl7A
         HEqmq8wEW6iaycFB53+G16TLed8gcZvXFJJQyGtpX5SEkByoZF8Ye+ROVqo+9SR4TLDS
         A1Wd5jGKDvyMnj4anueijud1k/GapbSBm+3eD7qa/mhk1+I3XqPI/fUEu9E6UdCrdw90
         9aBLK2rGex6U7OAoVcOacSei6EPhSQird3syuwNQn6bbXlEpZYehrrda2M4nuhDrYHLv
         J4sHl1CFSk7DnSEl9y+8WX6tlhr22aZCiJMGUjhye6MZOOdzAx5+cxljYSun1kn0igzn
         seJg==
X-Received: by 10.66.66.40 with SMTP id c8mr20979171pat.117.1437672074090;
        Thu, 23 Jul 2015 10:21:14 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:156f:a37c:e915:d6df])
        by smtp.gmail.com with ESMTPSA id j4sm10021680pdg.64.2015.07.23.10.21.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 23 Jul 2015 10:21:13 -0700 (PDT)
In-Reply-To: <20150723155936.GC14935@serenity.lan> (John Keeping's message of
	"Thu, 23 Jul 2015 16:59:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274509>

John Keeping <john@keeping.me.uk> writes:

> With a small number of items, there should only be one output line, but
> if xargs invokes the command multiple times there will be multiple
> lines.  For example (using -L2 to force a maximum of two arguments per
> invocation):
>
> 	$ printf '%s\n' a b c | xargs -d'\n' echo | wc -l
> 	1
> 	$ printf '%s\n' a b c | xargs -d'\n' -L2 echo | wc -l
> 	2

Yup, I think this thread is mistitled; it looks like an "unexpected
behaviour with xargs".  Or "common pitfalls with xargs", perhaps.

Now, what would be a reasonable workaround.  To work around command
line length limits (not necessarily for xargs, but the exact same
issue would arise if you are trying to specify too many pathspecs on
the command line), many of our commands take paths from their
standard input.  Would it be reasonable to teach "git archive" to
also do so?

Or would it make sense to teach "git archive -o" a new mode to
append to an existing archive, so that repeated invocations of "git
archive" via such a use of "xargs" would create in the first
invocation and then keep appending to the same archive in the
subsequent invocations?
