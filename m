From: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
Subject: [PATCH 00/18] Gitweb caching v8
Date: Thu,  9 Dec 2010 13:57:06 -0800
Message-ID: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 09 22:57:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQoUX-0007o9-VW
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 22:57:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757415Ab0LIVzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 16:55:48 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:51844 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757103Ab0LIVzr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 16:55:47 -0500
Received: from voot-cruiser.middle.earth (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id oB9LtePk027765
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 9 Dec 2010 13:55:45 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
X-Mailer: git-send-email 1.7.2.3
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Thu, 09 Dec 2010 13:55:46 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163348>

Afternoon everyone,

(Afternoon is like morning, right?)
 
This is the latest incarnation of gitweb w/ caching.  Per the general
consensus and requests from the recent Gittogether I'm re-submitting 
my patches.

Bunch of re-works in the code, and several requested features.  Sadly the
patch series has balloned as I've been adding things.  It was 3-4 patches,
it's now 18.  This is based on top of Jakub's v7.2 patch series, but
it should be more or less clean now.

As such there was a bunch of changes that I needed to do to Jakub's tree
which are indicated in the series.  Why did I do them up as separate things?
Mainly there's a bunch of history that's getting lost right now between
going back and forth, and I wanted to have clear patches to discuss
should further discussion be needed.

This still differs, by two patches, from whats in production on kernel.org.
It's missing the index page git:// link, and kernel.org and kernel.org also
has the forced version matching.  As a note I'll probably let this stew
another day or so on kernel.org and then I'll push it into the Fedora update
stream, as there's a couple of things in this patch series that would be 
good for them to have.

There is one additional script I've written that the Fedora folks are using,
and that might be useful to include, which is an 'offline' cache file generator.
It basically wraps gitweb.cgi and at the end moves the cache file into the right
place.  The Fedora folks were finding it took hours to generate their front
page, and that doing a background generation almost never completed (due to 
process death).  This was a simple way to handle that.  If people would like
I can add it in as an additional patch.

v8:
	- Reverting several changes from Jakub's change set that make no sense
                - is_cacheable changed to always return true - nothing special about
                  blame or blame_incremental as far as the caching engine is concerned
                - Reverted config file change "caching_enabled" back to "cache_enable" as this
                  config file option is already in the wild in production code, as are all
                  current gitweb-caching configuration variables.
                - Reverted change to reset_output as
                        open STDOUT, ">&", \*STDOUT_REAL;
                  causes assertion failures:
                  Assertion !((((s->var)->sv_flags & (0x00004000|0x00008000)) == 0x00008000) && (((svtype)((s->var)->sv_flags & 0xff)) == SVt_PVGV || ((svtype)((s->var)->sv_flags & 0xff)) == SVt_PVLV)) failed: file "scalar.xs", line 49 at gitweb.cgi line 1221.
                  if we encounter an error *BEFORE* we've ever changed the output.
        - Cleanups there were indirectly mentioned by Jakub
                - Elimination of anything even remotely looking like duplicate code
                        - Creation of isBinaryAction() and isFeedAction()
        - Adding in blacklist of "dumb" clients for purposes of downloading content
        - Added more explicit disablement of "Generating..." page
        - Added better error handling
                - Creation of .err file in the cache directory
                - Trap STDERR output into $output_err as this was spewing data prior to any header information being sent
        - Added hidden field in footer for url & hash of url, which is extremely useful for debugging

v7:
	- Rework output system, now central STDOUT redirect
	- Various fixes to caching brought in from existing
	  running system

v6:
	- Never saw the light of day
	- Various testing, and reworks.

v5:
	- Missed a couple of things that were in my local tree, and
	  added them back in.
	- Split up the die_error and the version matching patch
	- Set version matching to be on by default - otherwise this
	  really is code that will never get checked, or at best
	  enabled by default by distributions
	- Added a minor code cleanup with respect to $site_header
	  that was already in my tree
	- Applied against a more recent git tree vs. 1.6.6-rc2
	- Removed breakout patch for now (did that in v4 actually)
	  and will deal with that separately 

	http://git.kernel.org/?p=git/warthog9/gitweb.git;a=shortlog;h=refs/heads/gitweb-ml-v5

v4:
	- major re-working of the caching layer to use file handle
	  redirection instead of buffering output
	- other minor improvements

	http://git.kernel.org/?p=git/warthog9/gitweb.git;a=shortlog;h=refs/heads/gitweb-ml-v4
v3:
	- various minor re-works based on mailing list feedback,
	  this series was not sent to the mailing list.
v2:
	- Better breakout
	- You can actually disable the cache now

- John 'Warthog9' Hawley 


Jakub Narebski (2):
  gitweb: Prepare for splitting gitweb
  gitweb: Minimal testing of gitweb caching

John 'Warthog9' Hawley (16):
  gitweb: add output buffering and associated functions
  gitweb: File based caching layer (from git.kernel.org)
  gitweb: Regression fix concerning binary output of files
  gitweb: Add more explicit means of disabling 'Generating...' page
  gitweb: Revert back to $cache_enable vs. $caching_enabled
  gitweb: Change is_cacheable() to return true always
  gitweb: Revert reset_output() back to original code
  gitweb: Adding isBinaryAction() and isFeedAction() to determine the
    action type
  gitweb: add isDumbClient() check
  gitweb: Change file handles (in caching) to lexical variables as
    opposed     to globs
  gitweb: Add commented url & url hash to page footer
  gitweb: add print_transient_header() function for central header
    printing
  gitweb: Add show_warning() to display an immediate warning, with
    refresh
  gitweb: When changing output (STDOUT) change STDERR as well
  gitweb: Prepare for cached error pages & better error page handling
  gitweb: Add better error handling for gitweb caching

 gitweb/Makefile                           |   20 +-
 gitweb/gitweb.perl                        |  176 ++++++++++-
 gitweb/lib/cache.pl                       |  488 +++++++++++++++++++++++++++++
 gitweb/static/gitweb.css                  |    6 +
 t/gitweb-lib.sh                           |   16 +
 t/t9500-gitweb-standalone-no-errors.sh    |   20 ++
 t/t9501-gitweb-standalone-http-status.sh  |   13 +
 t/t9502-gitweb-standalone-parse-output.sh |   33 ++
 8 files changed, 762 insertions(+), 10 deletions(-)
 create mode 100644 gitweb/lib/cache.pl
 mode change 100644 => 100755 t/gitweb-lib.sh

-- 
1.7.2.3
