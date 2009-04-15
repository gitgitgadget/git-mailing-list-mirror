From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] fetch: Strip usernames from url's before storing them
Date: Wed, 15 Apr 2009 16:01:41 +0200
Message-ID: <49E5E8C5.4050501@op5.se>
References: <1239797816-24582-1-git-send-email-ae@op5.se> <49E5D372.1090504@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060004060302000504070101"
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Apr 15 16:03:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu5hv-0004SL-Ns
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 16:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753059AbZDOOBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 10:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752742AbZDOOBq
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 10:01:46 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:40384 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752685AbZDOOBp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 10:01:45 -0400
Received: by fg-out-1718.google.com with SMTP id e12so936716fga.17
        for <git@vger.kernel.org>; Wed, 15 Apr 2009 07:01:43 -0700 (PDT)
Received: by 10.86.31.18 with SMTP id e18mr176319fge.72.1239804103137;
        Wed, 15 Apr 2009 07:01:43 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id 4sm11088100fgg.0.2009.04.15.07.01.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Apr 2009 07:01:42 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <49E5D372.1090504@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116611>

This is a multi-part message in MIME format.
--------------060004060302000504070101
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Michael J Gruber wrote:
> Andreas Ericsson venit, vidit, dixit 15.04.2009 14:16:
>> When pulling from a remote, the full URL including username
>> is by default added to the commit message. Since it adds
>> very little value but could be used by malicious people to
>> glean valid usernames (with matching hostnames), we're far
>> better off just stripping the username before storing the
>> remote URL locally.
> 
> Uhm, this is for non-fast-forwards when pull uses "merge" and creates a
> merge commit, right?
> Fetch does not create commit messages, and pull does not either if it
> rebases. So maybe the commit message could make it clearer for lesser
> git-educated people such as myself ;)
> 

Yes and no. This alters what gets written to .git/FETCH_HEAD, but since
what's written there only ever turns up in the history in the form of a
commit-message, you're essentially right.

The reason for this patch is that we published some repositories publicly
a week or two ago and one such malicious person started attacking all our
public servers with the usernames found in the commit messages. In our
case, this isn't such a big issue since all of the servers just fake an
SSH daemon when connected to from outside our internal network, but we
shouldn't take too lightly on casual information disclosure. It *could*
have been a problem and, if nothing else, this patch will probably save
some diskspace if it can prevent others being targeted by the same kind
of brute-force attack as we were.

Junio, this is based off of master, but applies cleanly to maint as well.
I'd actually prefer it to go on maint than master. The usernames in the
url's provide no real value but are potentially dangerous to disclose.

Attached is the micro-program I wrote to test the function itself.
Since I couldn't quite figure out how to set up a remote repository with
password protection and then fetch from it in a way that was generic
enough to go into the test-suite I didn't bother with that, but issuing
a git-pull shows that FETCH_HEAD and the commit message gets the correct
text.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.

--------------060004060302000504070101
Content-Type: text/x-csrc;
 name="anon-url.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="anon-url.c"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define prefixcmp(haystack, needle) strncmp(haystack, needle, strlen(needle))
#define xcalloc(n, size) calloc(n, size)
#define xstrdup(str) strdup(str)

static char *anonymize_url(const char *url)
{
	char *anon_url;
	const char *at_sign = strchr(url, '@');
	size_t len, prefix_len = 0;

	if (!at_sign)
		return xstrdup(url);

	if (!prefixcmp(url, "ssh://"))
		prefix_len = strlen("ssh://");
	else if (!prefixcmp(url, "http://"))
		prefix_len = strlen("http://");
	else if (!prefixcmp(url, "https://"))
		prefix_len = strlen("https://");
	else if (!strchr(at_sign + 1, ':'))
		return xstrdup(url);

	len = prefix_len + strlen(at_sign + 1);
	anon_url = xcalloc(1, 1 + prefix_len + strlen(at_sign + 1));
	if (prefix_len)
		memcpy(anon_url, url, prefix_len);
	memcpy(anon_url + prefix_len, at_sign + 1, strlen(at_sign + 1));

	return anon_url;
}

int main(int argc, char **argv)
{
	int errors = 0;
	struct {
		char *raw;
		char *correct;
	}
	urls[] = {
		{ "rsync://host.xz/path/to/repo.git/", NULL, },
		{ "http://host.xz:port/path/to/repo.git/", NULL, },
		{ "https://host.xz:port/path/to/repo.git/", NULL,},
		{ "git://host.xz:port/path/to/repo.git/", NULL, },
		{ "git://host.xz:port/~user/path/to/repo.git/", NULL, },
		{
			"http://user@host.xz:port/path/to/repo.git/",
				"http://host.xz:port/path/to/repo.git/",
		},
		{
			"https://user@host.xz:port/path/to/repo.git/",
				"https://host.xz:port/path/to/repo.git/",
		},
		{
			"ssh://user@host.xz:port/path/to/repo.git/",
				"ssh://host.xz:port/path/to/repo.git/",
		},
		{
			"ssh://user@host.xz/path/to/repo.git/",
				"ssh://host.xz/path/to/repo.git/",
		},
		{
			"ssh://user@host.xz/~user/path/to/repo.git/",
				"ssh://host.xz/~user/path/to/repo.git/",
		},
		{
			"user@host.xz:/path/to/repo.git/",
				"host.xz:/path/to/repo.git/",
		},
		{
			"user@host.xz:~user/path/to/repo.git/",
				"host.xz:~user/path/to/repo.git/",
		},
		{ NULL, NULL },
	};
	int i;

	for (i = 0; urls[i].raw; i++) {
		char *anon_url = anonymize_url(urls[i].raw);
		if (!strcmp(anon_url, urls[i].correct ? urls[i].correct : urls[i].raw))
			continue;

		errors++;
		printf("raw    : %s\nanon   : %s\n", urls[i].raw, anon_url);
		printf("correct: %s\n", urls[i].correct);
	}

	printf("There were %d errors\n", errors);
	return 0;
}

--------------060004060302000504070101--
