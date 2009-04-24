From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] gitweb: filter escapes from longer commit titles that
	break firefox
Date: Fri, 24 Apr 2009 15:48:22 -0400
Message-ID: <20090424194822.GA15846@windriver.com>
References: <1239985473-666-1-git-send-email-paul.gortmaker@windriver.com> <m3r5znpt5g.fsf@localhost.localdomain> <49EC78AB.6020009@windriver.com> <200904241953.37187.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 21:50:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxRQ8-0006Yl-Iq
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 21:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754120AbZDXTtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 15:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753632AbZDXTtN
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 15:49:13 -0400
Received: from mail.windriver.com ([147.11.1.11]:62985 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753405AbZDXTtM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 15:49:12 -0400
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id n3OJn6Sl002219;
	Fri, 24 Apr 2009 12:49:06 -0700 (PDT)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 24 Apr 2009 12:49:05 -0700
Received: from yow-pgortmak-d1.corp.ad.wrs.com ([128.224.146.65]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 24 Apr 2009 12:49:05 -0700
Received: from paul by yow-pgortmak-d1.corp.ad.wrs.com with local (Exim 4.69)
	(envelope-from <paul.gortmaker@windriver.com>)
	id 1LxRNm-0004CI-8B; Fri, 24 Apr 2009 15:48:22 -0400
Content-Disposition: inline
In-Reply-To: <200904241953.37187.jnareb@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 24 Apr 2009 19:49:05.0610 (UTC) FILETIME=[B9A122A0:01C9C515]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117483>

[Re: [PATCH] gitweb: filter escapes from longer commit titles that break firefox] On 24/04/2009 (Fri 19:53) Jakub Narebski wrote:

> On Mon, 20 April 2009, Paul Gortmaker wrote:
> > Jakub Narebski wrote:
> >> Paul Gortmaker <paul.gortmaker@windriver.com> writes:
> >>
> >>   
> >>> If there is a commit that ends in ^X and is longer in length than
> >>> what will fit in title_short, then it doesn't get fed through
> >>> esc_html() and so the ^X will appear as-is in the page source.
> >>>
> >>> When Firefox comes across this, it will fail to display the page,
> >>> and only display a couple lines of error messages that read like:
> >>>
> >>>    XML Parsing Error: not well-formed
> >>>    Location: http://git ....
> >>>
> >>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
> >> But I do not think that the solution presented here is good solution
> >> for this problem.  chop_and_escape_str is meant as _output_ filter,
> >> because it generates (can generate) fragment of HTML.  It is not a
> >> good solution to use it for shortening in intermediate representation
> >> of %co{'title'}.
> >>
> >> And I think that issue might be a bug elsewhere in gitweb if we have
> >> text output which is not passed through esc_html... or bug in CGI.pm
> >> if the error is in not escaping of -title _attribute_ (attribute
> >> escaping has slightly different rules than escaping HTML, and should
> >> be done automatically by CGI.pm).
> >>
> >>
> >> So thanks for noticing the issue, but NAK on the solution.
> > 
> > Fair enough -- I wasn't familiar with the code in there, and there 
> > wasn't really any indication that it was for output only.  I can easily 
> > believe that there is a better place for it -- I just didn't see where 
> > any global esc_html filtering was taking place...
> 
> The name chop_and_escape_str for this subroutine is not a very good
> name; it rather should follow format_* as a naming convention for this
> subroutine.
> 
> What more important is: can you find out in more detail _where_
> an error (unescaped control character) occurs: is it tag contents or
> 'title' attribute for some tag, what tag is it (name and class), in
> what view or views this bug is present, and in which part this occur?
> Without those details it would b much harder to diagnose this bug...

No problem -- It appears to be in the title attribute, and it appears
straight away when I go to the toplevel view of the repo, assuming that
the commit is within the top 10 recent commits that are shown on the
summary page.  I've put more details below on how I can reproduce it
and the page source deltas -- hopefully this will help.  If there is
something else I can provide that would help, don't hesitate to ask.

Paul.

-------

Setup:

yow-d4:test$mkdir bad_commit
yow-d4:test$cd bad_commit/
yow-d4:bad_commit$git init
Initialized empty Git repository in /home/pgortmak/test/bad_commit/.git/
yow-d4:bad_commit$echo bbb > bbb
yow-d4:bad_commit$git add bbb
yow-d4:bad_commit$git commit -m 'some string that is longer than roughly
50chars, with a ^X embedded at the end^X'
[master (root-commit) 8735814] some string that is longer than roughly
50chars, with a ^X embedded at the end
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 bbb
yow-d4:bad_commit$
--------

I've used ^V^X to embed the ^X at the end of the commit message above;
the other "^X" is just literally a ^ followed by a X.

Then I load it with firefox (default shipping with Ubuntu Jaunty).
With my workaround patch sent previously, it renders OK, and I save
the source to "source-ok".  Then I take out my hack patch, and it fails
to render, instead giving:

------
XML Parsing Error: not well-formed
Location:
http://yow-somehost.com/gitweb/gitweb.cgi?p=local/pgortmak/test/bad_commit/.git;a=summary
Line Number 54, Column 114:<td><a class="list subject" title="some
string that is longer than roughly 50chars, with a ^X embedded at the
end"
href="/gitweb/gitweb.cgi?p=local/pgortmak/test/bad_commit/.git;a=commit;h=8735814a15cf930c48fd33563f5922a103b6b4ea">some string that is longer than roughly 50chars, with...  <span class="refs"> <span class="head" title="heads/master"><a href="/gitweb/gitweb.cgi?p=local/pgortmak/test/bad_commit/.git;a=shortlog;h=refs/heads/master">master</a></span></span></a></td>
-----------------------------------------------------------------------------------------------------------------^

You probably can't tell in mail, but the line of dashes and the caret
are pointing at firefox's rendering of the ^X at EOL, which is displayed
as a little square box with a 00 above an 18 inside it.

If I save this page to source-bad, and then diff the two, I get:

--- source-ok	2009-04-24 15:29:11.000000000 -0400
+++ source-bad	2009-04-24 15:30:20.000000000 -0400
@@ -54,9 +54,9 @@
 </div>
 <table class="shortlog">
 <tr class="dark">
-<td title="2009-04-24"><i>2 min ago</i></td>
+<td title="2009-04-24"><i>6 min ago</i></td>
 <td><i>Paul Gortmaker</i></td>
-<td><a class="list subject" title="some string that is longer than roughly 50chars, with a ^X embedded at the end&lt;span class=&quot;cntrl&quot;&gt;\18&lt;/span&gt;" href="/gitweb/gitweb.cgi?p=local/pgortmak/test/bad_commit/.git;a=commit;h=8735814a15cf930c48fd33563f5922a103b6b4ea">some string that is longer than roughly 50chars, with...  <span class="refs"> <span class="head" title="heads/master"><a href="/gitweb/gitweb.cgi?p=local/pgortmak/test/bad_commit/.git;a=shortlog;h=refs/heads/master">master</a></span></span></a></td>
+<td><a class="list subject" title="some string that is longer than roughly 50chars, with a ^X embedded at the end" href="/gitweb/gitweb.cgi?p=local/pgortmak/test/bad_commit/.git;a=commit;h=8735814a15cf930c48fd33563f5922a103b6b4ea">some string that is longer than roughly 50chars, with...  <span class="refs"> <span class="head" title="heads/master"><a href="/gitweb/gitweb.cgi?p=local/pgortmak/test/bad_commit/.git;a=shortlog;h=refs/heads/master">master</a></span></span></a></td>
 <td class="link"><a href="/gitweb/gitweb.cgi?p=local/pgortmak/test/bad_commit/.git;a=commit;h=8735814a15cf930c48fd33563f5922a103b6b4ea">commit</a> | <a href="/gitweb/gitweb.cgi?p=local/pgortmak/test/bad_commit/.git;a=commitdiff;h=8735814a15cf930c48fd33563f5922a103b6b4ea">commitdiff</a> | <a href="/gitweb/gitweb.cgi?p=local/pgortmak/test/bad_commit/.git;a=tree;h=8735814a15cf930c48fd33563f5922a103b6b4ea;hb=8735814a15cf930c48fd33563f5922a103b6b4ea">tree</a> | <a title="in format: tar.gz" href="/gitweb/gitweb.cgi?p=local/pgortmak/test/bad_commit/.git;a=snapshot;h=8735814a15cf930c48fd33563f5922a103b6b4ea;sf=tgz">snapshot</a></td>
 
 </tr>
