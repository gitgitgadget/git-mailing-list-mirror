From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 28/51] refs.c: rename ref_array -> ref_dir
Date: Tue, 13 Dec 2011 06:43:59 +0100
Message-ID: <4EE6E61F.8080405@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu> <1323668338-1764-29-git-send-email-mhagger@alum.mit.edu> <7v7h21xps9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010609020601020400060507"
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 13 06:44:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaLAN-0004tc-6k
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 06:44:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372Ab1LMFoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 00:44:24 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:46938 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041Ab1LMFoY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 00:44:24 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BEDFA7.dip.t-dialin.net [84.190.223.167])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBD5hxFg024843
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 13 Dec 2011 06:43:59 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <7v7h21xps9.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187003>

This is a multi-part message in MIME format.
--------------010609020601020400060507
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 12/13/2011 01:45 AM, Junio C Hamano wrote:
> mhagger@alum.mit.edu writes:
> 
>> From: Michael Haggerty <mhagger@alum.mit.edu>
>>
>> This purely textual change is in preparation for storing references
>> hierarchically, when the old ref_array structure will represent one
>> "directory" of references.  Rename functions that deal with this
>> structure analogously, and also rename the structure's "refs" member
>> to "entries".
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>  refs.c |  166 ++++++++++++++++++++++++++++++++--------------------------------
>>  1 files changed, 83 insertions(+), 83 deletions(-)
>>
>> diff --git a/refs.c b/refs.c
>> index fe6d657..b74ef80 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -106,9 +106,9 @@ struct ref_value {
>>  	unsigned char peeled[20];
>>  };
>>  
>> -struct ref_array {
>> +struct ref_dir {
>>  	int nr, alloc;
>> -	struct ref_entry **refs;
>> +	struct ref_entry **entries;
>>  };
> 
> The s/refs/entries/ renaming is a sane thing to do; on the other hand, I
> somehow find the s/ref_array/ref_dir/ renaming is a short-sighted change
> and undesirable, as you are essentially declaring that "if you use this
> structure, the contents you store there are expected to be named
> hierarchically", forbidding users that want to use a simple flat array.

This data structure is not exposed outside of the module, so it only
describes the de facto current storage scheme rather than making any
promises to the outside world.

> BUT. That was an observation before I continued reading the remainder of
> the series.

> I think the above observation primarily come from my worries around the
> extra ref stuff, which by nature does not fit well with the hierarchical
> naming (they do not even have any meaningful names). Sorting or requiring
> uniqueness among them do not make any sense, let alone cutting their names
> in hierarchical boundaries.
> 
> As an alternative, it _might_ make sense to get rid of "add_extra_ref()"
> API from refs.c and make it the responsibility for its users to add their
> extra anchor points where they use for_each_ref() to find out all anchor
> points in the history from the refs.c subsystem. If we go that route, I
> fully agree that "s/ref_array/ref_dir/" renaming is the right thing to do,
> as refs.c subsystem will _only_ handle the hierarchical ref namespace and
> nothing else after such a change.

I absolutely agree; the fact that extra refs are part of the refs module
has the foul smell of expedience.  And your suggestion for changing the
situation makes sense to me as far as I can follow it.  But I don't
think I have the gumption to attack another big part of the code base
before I've even finished the changes that I still have planned for the
refs API.

If somebody else wants to volunteer to make extra_refs redundant, I
would be happy to support that person on the refs side.

Otherwise, I propose to just avoid de-duping extra refs so that my patch
series doesn't make things worse.  If it is acceptable, I would prefer
to add the fix as a patch at the end of the series, because after

    struct ref_dir: store a reference to the enclosing ref_cache

ref_dir carries around information that can be used to distinguish
between the extra_refs and other ref caches.  I think it is as easy as
the attached patch (untested).

Apropos testing, it is unsettling that our test suite doesn't show any
failures after my changes.  The dir entries in extra_refs are now always
sorted and de-duped when do_for_each_ref() is called.  Could it be that
duplicate ".have" references never come up in the test suite?  It sounds
like an important code path is not being tested.  In particular, I won't
be able to test whether my fix works :-/

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/

--------------010609020601020400060507
Content-Type: text/x-patch;
 name="fix-dedup.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fix-dedup.diff"

diff --git a/refs.c b/refs.c
index 2d5c827..2fd3db2 100644
--- a/refs.c
+++ b/refs.c
@@ -457,7 +457,6 @@ static int is_dup_ref(const struct ref_entry *ref1, const struct ref_entry *ref2
  */
 static void sort_ref_dir(struct ref_entry *direntry)
 {
-	int i, j;
 	struct ref_entry *last = NULL;
 	struct ref_dir *dir;
 	assert(direntry->flag & REF_DIR);
@@ -468,19 +467,24 @@ static void sort_ref_dir(struct ref_entry *direntry)
 
 	qsort(dir->entries, dir->nr, sizeof(*dir->entries), ref_entry_cmp);
 
-	/* Remove any duplicates: */
-	for (i = 0, j = 0; j < dir->nr; j++) {
-		struct ref_entry *entry = dir->entries[j];
-		if (last && is_dup_ref(last, entry)) {
-			free_ref_entry(entry);
-		} else if (entry->flag & REF_DIR) {
-			dir->entries[i++] = entry;
-			last = NULL;
-		} else {
-			last = dir->entries[i++] = entry;
+	/* Remove any duplicates, but not for extra_refs: */
+	if (dir->ref_cache != NULL) {
+		int i, j;
+		for (i = 0, j = 0; j < dir->nr; j++) {
+			struct ref_entry *entry = dir->entries[j];
+			if (last && is_dup_ref(last, entry)) {
+				free_ref_entry(entry);
+			} else if (entry->flag & REF_DIR) {
+				dir->entries[i++] = entry;
+				last = NULL;
+			} else {
+				last = dir->entries[i++] = entry;
+			}
 		}
+		dir->nr = i;
 	}
-	dir->sorted = dir->nr = i;
+
+	dir->sorted = dir->nr;
 }
 
 #define DO_FOR_EACH_INCLUDE_BROKEN 01

--------------010609020601020400060507--
