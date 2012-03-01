From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: no-op "rebase -i" failures (easily reproduceable)
Date: Thu, 01 Mar 2012 11:45:16 -0800
Message-ID: <7vboogm7g3.fsf@alter.siamese.dyndns.org>
References: <CAFjr8EukvC6zsa2vzUWL+YDNLMUh5apmwGQZ1s5WkHg-bC17Kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luiz-Otavio Zorzella <zorzella@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 20:45:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3BwO-0007NI-EX
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 20:45:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757102Ab2CATpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 14:45:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57953 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756145Ab2CATpT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 14:45:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02A547B2F;
	Thu,  1 Mar 2012 14:45:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+NIlYwkRlNUXb2vYl3UHJbWMTmw=; b=ZQfZkf
	NDlM+LjqO5n6l03DotqpqXkLoTfHgalL/nm/lxnhHotbncX99pbR1YKdBhGqq7QO
	QfawlxmJT+hhD7WFpkg2gXD4fmV/+W3tr4AnNMGO7z0CMXrUBf5HmK1I/T0Er9SL
	CxjRWS2ycMJaJDEAdgHj2EZnAVzzVxG4ifs+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T+S6Opx8ZVCnOYsdkxf4Db3qtOmsQnzs
	ZmZkFR3RtSb8PgawhwRoEwh0Fx8CWoGQTi8RfZPXp3OyYkgKQhpP1EtAitmy410V
	b8gFym0Sq6Yu5vR7BSWGChAdupVm/XNY2C8Mnu70ZrZam9TGp2wcY9DCMfskicOc
	DP6/HOEn+28=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED7897B2E;
	Thu,  1 Mar 2012 14:45:18 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 632257B2D; Thu,  1 Mar 2012
 14:45:18 -0500 (EST)
In-Reply-To: <CAFjr8EukvC6zsa2vzUWL+YDNLMUh5apmwGQZ1s5WkHg-bC17Kw@mail.gmail.com>
 (Luiz-Otavio Zorzella's message of "Thu, 1 Mar 2012 10:47:08 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 12E8AFDC-63D7-11E1-B1BE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191963>

Luiz-Otavio Zorzella <zorzella@gmail.com> writes:

> $ EDITOR=echo git rebase -i HEAD~40
> /usr/local/google/z/gitblow/git/.git/rebase-merge/git-rebase-todo
> error: could not apply ec7ff5b... make lineno_width() from blame
> reusable for others
>
> When you have resolved this problem run "git rebase --continue".
> If you would prefer to skip this patch, instead run "git rebase --skip".
> To check out the original branch and stop rebasing run "git rebase --abort".
> Could not apply ec7ff5b... make lineno_width() from blame reusable for others

That is hardly surprising, given that you asked to flatten the history
since the 40 commits before the tip of your history, and it is done out of
a history that is full of merges from side branches.

And it is not even an error, let alone a bug.  The command is asking you
to resolve conflict it cannot resolve mechanically.  If you do as you are
asked, you will do just fine.

It is expected that you will see conflicts in such a rebase, because by
attempting to flatten the history you are telling Git to replay a commit
to a context that is different from its original context.

A conflict resolution to replay that particular commit to flatten a recent
history might look like this, but it depends on where in the history you
start the rebase from.

diff --cc cache.h
index 3a8e125,24732e6..0000000
--- a/cache.h
+++ b/cache.h
@@@ -1177,7 -1176,7 +1177,8 @@@ extern void setup_pager(void)
  extern const char *pager_program;
  extern int pager_in_use(void);
  extern int pager_use_color;
 +extern int term_columns(void);
+ extern int decimal_width(int);
  
  extern const char *editor_program;
  extern const char *askpass_program;
diff --cc pager.c
index b790967,96c07ba..0000000
--- a/pager.c
+++ b/pager.c
@@@ -118,32 -112,13 +118,44 @@@ int pager_in_use(void
  }
  
  /*
 + * Return cached value (if set) or $COLUMNS environment variable (if
 + * set and positive) or ioctl(1, TIOCGWINSZ).ws_col (if positive),
 + * and default to 80 if all else fails.
 + */
 +int term_columns(void)
 +{
 +	static int term_columns_at_startup;
 +
 +	char *col_string;
 +	int n_cols;
 +
 +	if (term_columns_at_startup)
 +		return term_columns_at_startup;
 +
 +	term_columns_at_startup = 80;
 +
 +	col_string = getenv("COLUMNS");
 +	if (col_string && (n_cols = atoi(col_string)) > 0)
 +		term_columns_at_startup = n_cols;
 +#ifdef TIOCGWINSZ
 +	else {
 +		struct winsize ws;
 +		if (!ioctl(1, TIOCGWINSZ, &ws) && ws.ws_col)
 +			term_columns_at_startup = ws.ws_col;
 +	}
 +#endif
 +
 +	return term_columns_at_startup;
 +}
++
++/*
+  * How many columns do we need to show this number in decimal?
+  */
+ int decimal_width(int number)
+ {
+ 	int i, width;
+ 
+ 	for (width = 1, i = 10; i <= number; width++)
+ 		i *= 10;
+ 	return width;
+ }
