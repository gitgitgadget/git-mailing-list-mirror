From: =?iso-8859-1?Q?Henrik_Grubbstr=F6m?= <grubba@roxen.com>
Subject: Re: [PATCH RFC 5/5] cache: Use ce_norm_sha1().
Date: Tue, 20 Apr 2010 17:39:15 +0200 (CEST)
Organization: Roxen Internet Software AB
Message-ID: <Pine.GSO.4.63.1004201622050.4296@shipon.roxen.com>
References: <cover.1271432034.git.grubba@grubba.org>
 <c68d98b384086925da0194e560ae01d83a29f80c.1271432034.git.grubba@grubba.org>
 <7vsk6qio1f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-641078858-1271777955=:4296"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 20 17:39:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4FXy-0000im-Ru
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 17:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546Ab0DTPj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Apr 2010 11:39:28 -0400
Received: from mail.roxen.com ([212.247.29.220]:60561 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750923Ab0DTPj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Apr 2010 11:39:27 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id D304462818C;
	Tue, 20 Apr 2010 17:39:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bzXo8kpN16R3; Tue, 20 Apr 2010 17:39:15 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id CE1EB62815B;
	Tue, 20 Apr 2010 17:39:15 +0200 (CEST)
In-Reply-To: <7vsk6qio1f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145385>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-641078858-1271777955=:4296
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 20 Apr 2010, Junio C Hamano wrote:

> "Henrik Grubbström (Grubba)"  <grubba@grubba.org> writes:
>
>> When the conversion filter for a file is changed, the file may get
>> listed as modified even though the user has not made any changes to it.
>> This patch makes the index ignore such changes. It also makes git-diff
>> compare with the normalized content rather than the original content.
>
> Hmm, I am not happy with this.  A typical use case I am imagining goes
> like this:
>
> 0. You have a project with LF line ending.  You clone to a filesystem
>    that needs autocrlf but somehow it is not set, and end up with files
>    with LF line ending in your working tree.

Ok, but note that LF is the canonical line ending in git.

> 1. You notice the mistake, and set autocrlf.  "git diff" does not say
>    anything, as the index is clean.

Ok.

> 2. Once you fixed the line endings in the working tree files, however,
>    "git diff" will say the files are different, but there is no actual
>    change (i.e. you see "diff --git a/file b/file" and nothing else).

Ok.

> 3. "git update-index --refresh" does not improve the situation, as it
>    (thinks) it knows the blob and the working tree file are different.

False. "git update-index --refresh" uses read-cache.c:ce_compare_data() to 
compare the content of the blob with the normalized content of the working 
tree, which both now and with my patch will return true (since the blob in 
the repository already is normalized with respect to CRLF).

Let's take the reverse case instead:

  0. For some reason a file using CRLF line endings has entered the
     repository.

  1. The user notices the mistake, and sets crlf. The index is still
     clean, but the user wants the file with LF line endings, so the
     user does a "git checkout -- the_file".

  2. The index is now dirty, so the user performs a "git update-index
     --refresh".

  Unpatched:
     update-index had no effect, since the normalized working tree
     file is compared with the unnormalized repository file. The
     user will have a dirty working tree until either the normalized
     file is committed, or the attribute change is reverted.

  Patched:
     update-index will compare with the normalized repository file,
     which will be equal to the normalized working tree file. The
     user now has a clean working tree.

> I was hoping to see a solution where you will add a stronger version of
> "refresh" without having to do anything else other than recording "how did
> I munge the file in the working tree to produce the blob".  The third step
> would change to:
>
> 3. "git update-index --refresh" notices that the conversion parameters
>    are different since the last time the files in the working tree were
>    looked at (i.e. immediately after a "clone", working tree files are
>    what git wrote out using convert_to_working_tree() and you know what
>    conversion you used; after the user modified files in the working tree
>    and said "git add", you know you what conversion parameters you ran
>    convert_to_git() with to produce blobs).  The paths that has different
>    conversion parameters are re-indexed to see if they hash to the same
>    sha1 as recorded in the index.  If they have changed, their index
>    entries are left intact (i.e. you will still show the differences);
>    otherwise you update the cached stat information for their index
>    entries.

I believe that most people that have edited a file that has changed CRLF 
convention aren't interested in that all lines have changed, but in only 
the lines that have actually been edited.

> The above example scenario is about crlf conversion, but the same idea
> should apply to other types of conversions (e.g. smudge/clear filter
> pair), no?

Yes, the same should apply to other conversions.

> I can see that it would be benefitial to store what conversions were used
> to turn the input into the canonical version that resulted in the object
> store and registered in the index, but I am not sure why the re-indexed
> versions need to be even stored in the index (either in-core, let alone
> on-disk) nor produce new blob objects.  What am I missing?

Storing the normalized sha1 is needed to reduce the amount of double work 
(eg having "git update-index --refresh" reperform convert_to_git() for
the repository blob every time a file is dirty, instead of (as now) just 
comparing the sha1 values).

Storing the normalized blob data helps reduce (or rather not increase) 
code complexity in eg "git diff", since the only change to the code is 
that a different blob sha1 is used.

The stored normalized blobs should take minimal space in the repository,
since:

  1). The most common case is most likely that the normalized blob is the
      same as the original blob (otherwise somebody else would have done
      this before).

  2). The normalized blob will probably often be stored as a delta, either
      against the original blob (eg ident), or backward against the next
      commit of the file (eg crlf).

  3). If the normalized blob isn't used in deltas, it will sooner or later
      be cleaned up by the gc.

--
Henrik Grubbström					grubba@grubba.org
Roxen Internet Software AB				grubba@roxen.com
---559023410-641078858-1271777955=:4296--
