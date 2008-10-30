From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [RFC] gitweb: add 'historyfollow' view that follows renames
Date: Thu, 30 Oct 2008 15:00:44 -0700
Message-ID: <4911F71203A09E4D9981D27F9D8308580AEC1324@orsmsx503.amr.corp.intel.com>
References: <054F21930D24A0428E5B4588462C7AED0149B4B8@ednex512.dsto.defence.gov.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Blucher, Guy" <Guy.Blucher@dsto.defence.gov.au>,
	"Lin, Ming M" <ming.m.lin@intel.com>,
	"jnareb@gmail.com" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 23:02:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kvfae-0005SN-N5
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 23:02:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291AbYJ3WAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 18:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753166AbYJ3WAu
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 18:00:50 -0400
Received: from mga14.intel.com ([143.182.124.37]:19013 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753277AbYJ3WAt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Oct 2008 18:00:49 -0400
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga102.ch.intel.com with ESMTP; 30 Oct 2008 15:00:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.33,518,1220252400"; 
   d="scan'208";a="67937628"
Received: from unknown (HELO azsmsx001.amr.corp.intel.com) ([10.2.167.98])
  by azsmga001.ch.intel.com with ESMTP; 30 Oct 2008 15:00:48 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.226.211) by
 azsmsx001.amr.corp.intel.com (10.2.167.98) with Microsoft SMTP Server (TLS)
 id 8.1.311.2; Thu, 30 Oct 2008 15:00:47 -0700
Received: from orsmsx503.amr.corp.intel.com ([10.22.226.47]) by
 orsmsx602.amr.corp.intel.com ([10.22.226.211]) with mapi; Thu, 30 Oct 2008
 15:00:45 -0700
Thread-Topic: [RFC] gitweb: add 'historyfollow' view that follows renames 
Thread-Index: Ack34pbqvQjKSPtnQv+obtOLtdhvoAC+E9pQ
In-Reply-To: <054F21930D24A0428E5B4588462C7AED0149B4B8@ednex512.dsto.defence.gov.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99525>

Thanks. This sounds like what we need.

We will take a look at it.
Bob


>-----Original Message-----
>From: Blucher, Guy [mailto:Guy.Blucher@dsto.defence.gov.au]
>Sent: Sunday, October 26, 2008 8:18 PM
>To: Lin, Ming M; jnareb@gmail.com; Moore, Robert
>Cc: git@vger.kernel.org
>Subject: [RFC] gitweb: add 'historyfollow' view that follows renames
>
>
>Hi Folks,
>
>>>
>>> What should we add to automatically get all file history?
>
>> While the 'commitdiff' view would, in default gitweb configuration,
>> contain information about file renames, currently 'history' view does
>> not support '--follow' option to git-log.  It wouldn't be too hard to
>> add it, but it just wasn't done (well, add to this the fact that
>> --follow works only for simple cases).
>
>We also ran up against this issue because renaming of files in our
>project is a useful bit of information while browsing file history.
>
>I hacked gitweb to add a 'historyfollow' viewing option in addition to
>the 'history' option.  Yes, '--follow' is expensive so I didn't just
>make it the default 'history' behaviour.
>
>The only problem with doing it was that parse_commits in gitweb.perl
>uses git rev-list which doesn't support the '--follow' option like
>git-log does. A bit of hacking to use 'git log --pretty=raw -z' to make
>the output look close to that from rev-list means only minor
>shoe-horning is required (perhaps it would be better to make rev-list
>understand --follow though?).
>
>I wasn't originally prepared to publish the work here because I don't
>really think it's the best solution. But considering it's come up... I
>include a patch inline against gitweb.perl from v1.6.0.3 that implements
>a 'historyfollow' view.
>
>Feel free to do with it what you will. It would need some substantial
>tidying up by someone who knows much more about perl than me :)
>
>We use it such that anywhere a 'history' link is provided a
>'historyfollow' link is also provided next to it - This patch doesn't
>implement that bit though.
>
>Hope it helps.
>
>Cheers,
>Guy.
>
>---
>
>--- a/gitweb/gitweb.perl
>+++ b/gitweb/gitweb.perl
>@@ -478,6 +478,7 @@ my %actions = (
>        "forks" => \&git_forks,
>        "heads" => \&git_heads,
>        "history" => \&git_history,
>+       "historyfollow" => \&git_history_follow,
>        "log" => \&git_log,
>        "rss" => \&git_rss,
>        "atom" => \&git_atom,
>@@ -2311,25 +2312,39 @@ sub parse_commit {
> }
>
> sub parse_commits {
>-       my ($commit_id, $maxcount, $skip, $filename, @args) = @_;
>+       my ($commit_id, $maxcount, $skip, $mode, $filename, @args) = @_;
>        my @cos;
>
>        $maxcount ||= 1;
>        $skip ||= 0;
>
>        local $/ = "\0";
>+        # The '--max-count' argument is not available when doing a
>+        # '--follow' to 'git log'
>+        my $count_arg = ("--max-count=" . $maxcount) ;
>+        if (defined $mode && $mode eq "--follow") {
>+            $count_arg = "--follow" ;
>+        }
>
>-       open my $fd, "-|", git_cmd(), "rev-list",
>-               "--header",
>+
>+       open my $fd, "-|", git_cmd(), "log",
>+               "-z",
>+               "--pretty=raw",
>                @args,
>-               ("--max-count=" . $maxcount),
>+                ($count_arg ? ($count_arg ) : ()),
>                ("--skip=" . $skip),
>                @extra_options,
>                $commit_id,
>                "--",
>                ($filename ? ($filename) : ())
>-               or die_error(500, "Open git-rev-list failed");
>+               or die_error(500, "Open git-log failed");
>        while (my $line = <$fd>) {
>+               # Need to put a delimiter on the end of output
>+                # 'git-log -z' doesn't put one before EOF like rev-list
>does
>+                $line = ($line . '\0');
>+                # Need to strip the word commit from the start so it
>+                # looks like rev-list output
>+                $line =~ s/^commit // ;
>                my %co = parse_commit_text($line);
>                push @cos, \%co;
>        }
>@@ -5363,6 +5378,13 @@ sub git_commitdiff_plain {
> }
>
> sub git_history {
>+        my $mode = shift || '';
>+        my $history_call = "history";
>+
>+       if ($mode eq "--follow") {
>+           $history_call .= "historyfollow" ;
>+       }
>+
>        if (!defined $hash_base) {
>                $hash_base = git_get_head_hash($project);
>        }
>@@ -5377,7 +5399,7 @@ sub git_history {
>        my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
>
>        my @commitlist = parse_commits($hash_base, 101, (100 * $page),
>-                                      $file_name, "--full-history")
>+                                      $mode, $file_name,
>"--full-history")
>            or die_error(404, "No such file or directory on given
>branch");
>
>        if (!defined $hash && defined $file_name) {
>@@ -5398,7 +5420,7 @@ sub git_history {
>        my $paging_nav = '';
>        if ($page > 0) {
>                $paging_nav .=
>-                       $cgi->a({-href => href(action=>"history",
>hash=>$hash, hash_base=>$hash_base,
>+                       $cgi->a({-href => href(action=>"$history_call",
>hash=>$hash, hash_base=>$hash_base,
>                                               file_name=>$file_name)},
>                                "first");
>                $paging_nav .= " &sdot; " .
>@@ -5429,6 +5451,11 @@ sub git_history {
>        git_footer_html();
> }
>
>+sub git_history_follow {
>+       git_history('--follow');
>+}
>+
>+
> sub git_search {
>        gitweb_check_feature('search') or die_error(403, "Search is
>disabled");
>        if (!defined $searchtext) {
>@@ -5469,7 +5496,7 @@ sub git_search {
>                        $greptype = "--committer=";
>                }
>                $greptype .= $searchtext;
>-               my @commitlist = parse_commits($hash, 101, (100 *
>$page), undef,
>+               my @commitlist = parse_commits($hash, 101, (100 *
>$page), undef, undef,
>                                               $greptype,
>'--regexp-ignore-case',
>                                               $search_use_regexp ?
>'--extended-regexp' : '--fixed-strings');
>
>@@ -5737,7 +5764,7 @@ sub git_feed {
>
>        # log/feed of current (HEAD) branch, log of given branch,
>history of file/directory
>        my $head = $hash || 'HEAD';
>-       my @commitlist = parse_commits($head, 150, 0, $file_name);
>+       my @commitlist = parse_commits($head, 150, 0, undef,
>$file_name);
>
>        my %latest_commit;
>        my %latest_date;
>---
>
>Guy.
>____________________________________________________
>Guy Blucher
>Defence Science and Technology Organisation
>AUSTRALIA
>
>IMPORTANT : This email remains the property of the Australian Defence
>Organisation and is subject to the jurisdiction of section 70 of the
>Crimes Act 1914.  If you have received this email in error, you are
>requested to contact the sender and delete the email.
