From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: [PATCH/RFC 2/4] Use 'lstat_cache()' instead of
 'has_symlink_leading_path()'
Date: Tue, 06 Jan 2009 13:50:54 +0100
Organization: private
Message-ID: <86r63gk381.fsf@broadpark.no>
References: <1231161001-32599-1-git-send-email-barvik@broadpark.no>
 <1231161001-32599-3-git-send-email-barvik@broadpark.no>
 <7vk598j17u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 13:52:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKBPw-0008R7-T8
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 13:52:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbZAFMu5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 07:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751727AbZAFMu5
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 07:50:57 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:62239 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbZAFMu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 07:50:56 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KD1006WCVOV9Q80@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Tue, 06 Jan 2009 13:50:55 +0100 (CET)
Received: from localhost ([80.202.166.60]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KD10002DVOTIID0@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Tue, 06 Jan 2009 13:50:55 +0100 (CET)
In-reply-to: <7vk598j17u.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104682>

Junio C Hamano <gitster@pobox.com> writes:

> Kjetil Barvik <barvik@broadpark.no> writes:
>
>> Start using the optimised, faster and more effective symlink/directory
>> cache.  The previously used call:
>>
>>    has_symlink_leading_path(len, name);
>>
>> should be identically with the following call to lstat_cache():
>>
>>    lstat_cache(len, name,
>>                LSTAT_SYMLINK|LSTAT_DIR,
>>                LSTAT_SYMLINK);
>> ...
>
> Care to enlighten why some of callers use the above, but not others?
> Namely, check_removed() in diff-lib.c 

  I though that first it would be a good thing to introduce as little
  changes as possible, and then later on do some cleanups.  Regarding
  the 'check_removed()' function, I though that it could later have been
  written something like this after cleanups:

[....]
static int check_removed(const struct cache_entry *ce, struct stat *st)
{
	unsigned int ret_flags =
		check_lstat_cache(ce_namelen(ce), ce->name,
				  LSTAT_SYMLINK|LSTAT_NOTDIR|LSTAT_DIR);

	if (ret_flags & (LSTAT_SYMLINK|LSTAT_NOTDIR))
		return 1;
	if (ret_flags & LSTAT_LSTATERR)
		return -1;

	if (ret_flags & LSTAT_DIR) {
		unsigned char sub[20];
[....]

  This would have saved one more lstat() call in some cases.  But after
  a test, I now see that it does not work.  The reason is that it does
  not set the 'struct stat *st' parameter and/or that for the moment you
  can not tell the 'lstat_cache()' function to also always test the last
  path component.  It could be extended to do this, if someone ask for
  it and if it would be useful to extend the lstat_cache() for this
  fact.

  I will remove the '|LSTAT_NOTDIR' part from the call to lstat_cache()
  in 'check_removed()' in the next version of the patch.

> and callers in unpack-trees.c care about NOTDIR unlike others, even
> though the original code checked for exactly the same condition.

  Regarding the 'verify_absent()' function in unpack-trees.c, the
  '|LSTAT_NOTDIR' part of the call to lstat_cache() helps to avoid 16047
  lstat() calls for the given test case mentioned in the cover-letter.
  And from the source code:

  [...]
	if (lstat_cache(ce_namelen(ce), ce->name,
			LSTAT_SYMLINK|LSTAT_NOTDIR|LSTAT_DIR,
			LSTAT_SYMLINK|LSTAT_NOTDIR))
		return 0;

	if (!lstat(ce->name, &st)) {
  [...]

  it should be easy to see that if we from the lstat_cache() could
  already spot that some path component of ce->name does not exists,
  then we can avoid the following lstat() call, as it then should known
  to be failing.

  regarding the 'unlink_entry()' function in unpack-trees.c, the
  '|LSTAT_NOTDIR' part of the call to lstat_cache() does not for the
  moment helps to avoid any lstat() calls, as far as I can see.  But,
  again, from the source code:

  [..]
	char *name = ce->name;

	if (lstat_cache(ce_namelen(ce), ce->name,
			LSTAT_SYMLINK|LSTAT_NOTDIR|LSTAT_DIR,
			LSTAT_SYMLINK|LSTAT_NOTDIR))
		return;
	if (unlink(name))
		return;
  [...]

  it should be correct, since if we already know that some path
  component of ce-name does not exist, the call to unlink(name) would
  always fail (with ENOENT).

> Does this mean that some callers of has_symlink_leading_path() checked
> only for leading symlinks when they should also have checked for a leading
> non-directory, and this patch is also a bugfix?

  Yes, as indicated above, has_symlink_leading_path() should have
  checked for leading non-directories when called from for the
  'verify_absent()' function to be able to optimise away some more
  lstat() calls.

  I admit that I do not know the source code good enough to decide if
  this is an indication of a bug somewhere, or just an optimisation.

  -- kjetil
