From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Locate git helpers with type -P, for when git --exec-path is multivalued
Date: Thu, 22 Mar 2012 10:43:36 +0100
Message-ID: <87pqc5ged3.fsf@thomas.inf.ethz.ch>
References: <1332407219-7774-1-git-send-email-domq@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: Dominique Quatravaux <domq@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 10:43:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAeYb-0007w1-Ax
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 10:43:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755912Ab2CVJnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 05:43:40 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:2135 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754315Ab2CVJnj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 05:43:39 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 22 Mar
 2012 10:43:35 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 22 Mar
 2012 10:43:36 +0100
In-Reply-To: <1332407219-7774-1-git-send-email-domq@google.com> (Dominique
	Quatravaux's message of "Thu, 22 Mar 2012 10:06:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193638>

Dominique Quatravaux <domq@google.com> writes:

> Under a setting of (eg) GIT_EXEC_PATH=/home/joe/bin:/usr/lib/git-core,
> constructs such as
>
>   . "$(git --exec-path)"/git-sh-setup
>
> do not work. The proper way is
>
>   . "$(PATH="$(git --exec-path)" type -p git-sh-setup)"

NAK.  The documented(!) way of loading git-sh-setup is

  . "$(git --exec-path)/git-sh-setup"

and we can't break that.  I don't know where you are getting your
multivalued GIT_EXEC_PATH from, but there are other places in the code
that assume a single path, too.  For example, the callchain (irrelevant
stuff snipped)

void setup_path(void)
{
	add_path(&new_path, git_exec_path());
}

static void add_path(struct strbuf *out, const char *path)
{
	if (path && *path) {
		if (is_absolute_path(path))
			strbuf_addstr(out, path);
		else
			strbuf_addstr(out, absolute_path(path));

		strbuf_addch(out, PATH_SEP);
        }
}

makes no sense at is_absolute_path(path) if path is multivalued.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
