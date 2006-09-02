From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC] gitweb wishlist and TODO list
Date: Sat, 2 Sep 2006 18:17:08 +0200
Message-ID: <200609021817.09296.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Sep 02 18:17:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJYBP-0007W8-HN
	for gcvg-git@gmane.org; Sat, 02 Sep 2006 18:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWIBQRF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Sep 2006 12:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWIBQRF
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Sep 2006 12:17:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:44 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751145AbWIBQRC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Sep 2006 12:17:02 -0400
Received: by ug-out-1314.google.com with SMTP id m3so1185149ugc
        for <git@vger.kernel.org>; Sat, 02 Sep 2006 09:17:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:user-agent:mime-version:content-disposition:date:content-type:content-transfer-encoding:message-id;
        b=hLACkuAPpZ6Y3EJUjnNvvMiov4yX+WAGuFaiWWDD36pviDMGxkvhPkvLVtZOYZNGClY3tm7wPNOymmh0vbVWrhohpA5l64BlUMNMchXRfUj5fDOkWfD9UgNmhKuowxQ+W5R6ACkivQ6aqdp2AZWcRONO/st8ciRULGX6QzFx/nI=
Received: by 10.67.117.18 with SMTP id u18mr1814519ugm;
        Sat, 02 Sep 2006 09:16:59 -0700 (PDT)
Received: from host-81-190-21-28.torun.mm.pl ( [81.190.21.28])
        by mx.gmail.com with ESMTP id q40sm5022800ugc.2006.09.02.09.16.58;
        Sat, 02 Sep 2006 09:16:59 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26342>

This is second series of planned gitweb features. Still ideas for many 
of them come from xmms2's gitweb version, which can you see in work at
  http://git.xmms.se/?p=gitweb-xmms2.git;a=summary
Some of gitweb features like snapshot support and clone/fetch URL were 
implemented, some of cleanup like refactoring navbar generation or 
putting CSS into separate style file too.

I have put the list here for three reasons. First to get input which 
features are most wanted, and to receive perhaps ideas for new 
features. Second, to have TODO list, and receive input if somebody is 
doing implementing some of the features to avoid duplicate work. Third, 
and most important, some of features needs discussion about _how_ to 
implement them.

Copy sent to Sham Chukoury, owner of gitweb-xmms2.


Cleanup, tidying, refactoring:
* HTML code still needs cleanup. All elements should have be either
  assigned class, or given unique id. Presentational elements like <i>
  or <b> should be replaced by styling using CSS. Page should be divided
  into block elements; avoid overuse of <br/>.

* CSS cleanup. Names of classes should reflect intent, not be
  replacement for presentational elements, or be incomprehensive:
  e.g. classes age0, age1, age2, dark, light. padding: 8px; repeats many
  times, perhaps it could be replaced by setting margin in encompassing
  element, or via inheritance or additional class.

* Separate generating link and related links to object 
  (e.g. "blob | blame | history | raw" for blob in "tree" view)
  into subroutine, similarly to refactoring navbar. The problem is that
  the set of links depends not only on the type of object, but also on
  the action/view we are in, for example links to commit object might
  be either "commit | commitdiff", or "log | shortlog" if the commit is
  considered ref. DISCUSSION needed.

* Collapse similar subroutines into one, e.g. git_blob and
  git_blob_plain, and use parameter to set format. Perhaps instead of
  having
	sub git_commitdiff_plain {
		git_commitdiff('plain');
	}
  we can simply use
	my %actions = (
		# ...
		"commitdiff_plain" => sub { git_commitdiff('plain'); }
		# ...
	);
  Which of this options is more readable, which one is faster?

* Refactoring formatsnav similarly to commit/hashbase related main
  navbar (upper part of navbar now). For blob it would be "html",
  "plain", "blame", "head" (or "base"), optionally "HEAD", "history",
  perhaps later "highlight". For tree it would be "tree", "blame" and
  "history". For commit it would be "html", "plain", and "combined" 
  if applicable.

* Perhaps some of the views should be made into format, e.g. 'shortlog'
  and 'log' (and perhaps 'rss') for log views (this includes
  "log"/"shortlog" and "history" views), or 'html', 'opml' and
  'plain'/'index' for "project_list". DISCUSSION encouraged.

* Things like description or cloneurls (repourls) and further category
  should be perhaps available to set in repository config, not only from
  additional files in repository.


Gitweb speed:
* Ensure that gitweb is compatibile with mod_perl not only in
  Apache::Registry/ModPerl::Registry CGI script compatibility mode,
  but also as native mod_perl handler/script. Make it easy to use
  FastCGI instead of CGI (perhaps via CGI::Fast).

  This could be ensured by creating 'handler'/'main' method which
  does parameter reading, validation and dispatching action. Perhaps
  we should add gitweb_params subroutine, which given the names
  of parameters returns values of needed parameters (either as list of
  parameter names and returning list of parameters in order set by
  subroutine argument, or as hash with keys and undefined values and
  returning hash or hashref with values filled). The exception being
  project and action parameters, which must be accessed before
  dispatching action.

  We could make script options parameters my() again, and leave our()
  only for global variables which changes from invocation to invocation,
  like $project, $action, $git_dir etc.  

* Add new CORE GIT command, git-show-refs, which returns for given
  by glob set of refs required fields (specified by --format option),
  sorted by given field (specified by --sort option). This would speed
  up "tags" and "summary" views considerably.

  See Junio post in "[PATCH/RFC] gitweb: Great subroutines renaming"
  thread for proposed git-show-refs options.
    http://permalink.gmane.org/gmane.comp.version-control.git/25055
    Message-Id: <7vejvsyum8.fsf@assigned-by-dhcp.cox.net>

* Try to avoid unnecessary calls to git commands, try do do things
  using one command. For example instead of getting list of revisions
  from git-rev-list, then parsing commit after commit use one 
  git-rev-list invocation to get and parse list of revisions.

  It would be easier if some CORE GIT commands, for example git-ls-tree,
  acquired --stdin option, similarly to git-diff-tree (and output
  revision before output for that revison, like git-diff-tree).

* In the future, use Git.pm


Improvements of existing views and features:
* Make pickaxe search a feature (as it is expensive), and document
  existing search operators. Perhaps refactor git_search as well.

* Make history follow renames. This could I think be done without CORE
  GIT support, but it would be better with it. The proposition is to add
  --follow option to git-rev-list (or -C, -M, -B options), which would
  make if follow renames in files in path limit; I think following
  renames with pathspec being glob is out, unless we expand glob to
  individual file names and then follow those, and that following
  directory renames would be very hard if not impossible.

  Additionally make git-rev-list output current path limit, in format
  suitable as argument for other git commands like git-diff-tree, i.e.
  	<hash> -- <path limit>
  instead of current
  	<hash>
  Make git-diff-tree at least accept and understand this kind of input
  also on stdin with --stdin option.

* Perhaps add number of changed lines to the short information about
  blob (perhaps via title to patch/diff link?), and diffstat to
  "commitdiff_plain" view.

* Parse $GIT_DIR/remotes/ to mark tracking branches in "heads" view,
  e.g. as a popup.


New features:
* Categories support (from gitweb-xmms2), although I'm not sure about
  adding yet another file "category" to git repository. Perhaps first
  part of dirname could serve as category name, or we could use
  gitweb.category configuration variable.

* Code highlighting in blob view (from gitweb-xmms2), or to generalize
  to allow for generalized filter. The higlighter should have support
  for HTML support, it should always close elements before end of line,
  it would be better if it used CSS for styling, and it should accept
  file to highlight on standard input. gitweb-xmms2 uses Highlight
    http://www.andre-simon.de/
  but GNU Highlight (src-hilite) could be used instead
    http://www.gnu.org/software/src-highlite/

* Committags support, i.e. extend hyperlinking commit sha1 to commit
  view to hyperlinking bug #nn/BUG(nn) to the proper bugtracker, in both
  commit message view and (harder to do properly) in commit
  title/subject line which is hyperlink itself. The problem is how to do
  this general enough...

  I have thought about structure somewhat similar to %feature hash, i.e.
  something like %commitfilter hash, with 'enabled', 'override', 'name',
  'options' or something like that and of course 'sub' (as we probably
  would use $cgi->a(...) to construct hyperlink, and not simple regexp
  replacement.

  DISCUSSION needed.

* Etags/Ctags/LXR based anchors in the blob view. In gitweb-xmms2 they
  use temporary file to avoid race condition for both etags and
  highlighting. Is it worth doing? GNU Highlight has ctags
  (encumberant-ctags) support built in, I don't know about Highlight.


New views:
* Reflog support: show history of branch. I'm not sure if it is worth
  doing, as of now reflogs are local matter, and doesn't get copied on
  push even to bare repository.

* ViewVC-like "tree_blame" view. It probably would need CORE GIT support
  to have acceptable speed, although version using git-ls-tree wasn't
  that slow. Or at least git-ls-tree with --stdin support.

* gitk-ish (qgit-ish) view, with graph showing branches forking and
  merging. Not that easy, but probably possible.


In the future:
* AJAX-ize parts of gitweb.


Comments? Other ideas? <wishful thinking>Code?</wishful thinking>
-- 
Jakub Narebski
ShadeHawk on #git
Poland

-- 
VGER BF report: H 0
