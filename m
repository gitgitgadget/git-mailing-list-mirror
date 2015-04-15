From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Odd broken "--date=now" behavior in current git
Date: Wed, 15 Apr 2015 03:22:23 -0400
Message-ID: <20150415072223.GA1389@flurp.local>
References: <CA+55aFxvcN8Dz-t6fi6etycg+AiyR0crXv5AcfCdv8ji-iNBpw@mail.gmail.com>
 <xmqqzj6ayp3p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 09:22:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiHeg-0002ah-GF
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 09:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753098AbbDOHWd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 03:22:33 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:35408 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106AbbDOHWc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 03:22:32 -0400
Received: by obbfy7 with SMTP id fy7so11470668obb.2
        for <git@vger.kernel.org>; Wed, 15 Apr 2015 00:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=k0QMbvCzIhDVCuXTbRZHkTA7435K9I4jX8W0p506+Jw=;
        b=CoqWYCVEP7gP3YoBYM2nex4u8IOM3wvrghjM39eJ5NA05EeJAWzRuvSklHH7fHX0Of
         oxWNxXHrPHA6EhlMUE/ro2xeavVk32W4mA3aI+yOURjde9QZzXKpJ0avzFaoOWGyCJlh
         t9XGDTSA+cB3pjCRuoq3DbYxJTeLjSUhNv7wTy7XsB74B/1hN+KTJTRolhxen99Dsumo
         zo7bj1RR2MsZO/t46c774KKsWBJm0zhGEq9+7JrfZpsmpj6SqbLsj9siljcyPrMopOC6
         ZOSbcDmwXAPt12mJiMyaZ7QO6soHgYgf0wLj6izZgsH+tIYtE9TfYuf7anS4JXDgkXZv
         ngew==
X-Received: by 10.107.17.29 with SMTP id z29mr34601467ioi.69.1429082552276;
        Wed, 15 Apr 2015 00:22:32 -0700 (PDT)
Received: from flurp.local (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id s85sm1896227ioe.28.2015.04.15.00.22.30
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 15 Apr 2015 00:22:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqzj6ayp3p.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267188>

On Tue, Apr 14, 2015 at 09:47:38PM -0700, Junio C Hamano wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> > Lookie here, I can reproduce it trivially with current git (in the git
> > repo itself):
> >
> >     [torvalds@i7 git]$ date; git commit -m Test --allow-empty --date=now
> >     Tue Apr 14 21:11:03 PDT 2015
> >     [master ec7733db5360] Test
> >      Date: Tue Apr 14 20:11:03 2015 -0800
> >
> > notice how the commit date message shows something funny. It shows an
> > hour earlier, but in -0800.
> >
> > And the resulting commit is broken:
> >
> >     [torvalds@i7 git]$ git show --pretty=fuller
> >     commit ec7733db5360966434e03eab1a849e6d4227231c (HEAD -> master)
> >     Author:     Linus Torvalds <torvalds@linux-foundation.org>
> >     AuthorDate: Tue Apr 14 20:11:03 2015 -0800
> >     Commit:     Linus Torvalds <torvalds@linux-foundation.org>
> >     CommitDate: Tue Apr 14 21:11:03 2015 -0700
> >
> >         Test
> >
> > notice how the AuthorDate has that "-0800", but the CommitDate has "-0700".
> 
> With a quick check, the symptom exists at least at v2.1.4.  v2.0.x
> series does not seem to have --date=now support but since there is
> no change to date.c between v2.0.0 to v2.1.4, older approxidate may
> be equally broken.
> 
> Will dig tomorrow, if nobody beats me to it, that is.

I'm not familiar with this code, but have been studying it since
reading this email, and I think I know what's going on. The problem
isn't with "approxidate", but rather with the date form "@nseconds"
returned by approxidate. builtin/commit.c calls fmt_ident() with the
"@nseconds" date, which calls parse_date(), which finally calls
parse_date_basic(), and therein lies the problem.

parse_date_basic() does correctly set tm_isdst=-1, however, when it
encounters a date of form "@nseconds", it invokes match_digit() which
calls gmtime_r() to fill in the 'tm' structure, and gmtime_r() sets
tm_isdst=0 (since DST is definitely false at GMT).

Later parse_date_basic() computes the offset from GMT by comparing
the values returned by tm_to_time_t() and mktime(). The existing 'tm'
is passed to mktime() with the tm_isdst field already set to 0 by
gmtime_r(), and mktime() respects that as a statement that DST is not
in effect, rather than determining it dynamically.

The fix seems to be simply:

---- >8 ----
diff --git a/date.c b/date.c
index 3eba2df..99ad2a0 100644
--- a/date.c
+++ b/date.c
@@ -707,6 +707,7 @@ int parse_date_basic(const char *date, unsigned long *timestamp, int *offset)
 	/* mktime uses local timezone */
 	*timestamp = tm_to_time_t(&tm);
 	if (*offset == -1) {
+		tm.tm_isdst = -1;
 		time_t temp_time = mktime(&tm);
 		if ((time_t)*timestamp > temp_time) {
 			*offset = ((time_t)*timestamp - temp_time) / 60;
---- >8 ----

However, I'm still digesting the code, so I haven't fully convinced
myself that that's all that's needed. (It doesn't break any tests,
and it does fix this issue.)
