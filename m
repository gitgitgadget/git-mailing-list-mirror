X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC] gitweb wishlist and TODO list (part 1)
Date: Sun, 17 Dec 2006 00:00:05 +0100
Message-ID: <200612170000.06771.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 16 Dec 2006 23:00:20 +0000 (UTC)
Cc: Kernel Org Admin <ftpadmin@kernel.org>, Petr Baudis <pasky@suse.cz>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=MEypas+/PGI6gMITigqaoqKWrTl8S6UKHCrQFx6w0Uxe2a3XcSxSZbNydsBKkwBmvFLbsdmHIC8ZhZQAJ25NFjwH2WUJ5OfPWnkxCo3En9SbnSPCbkV6oMogy5wqJJia/9iGI0h7L5NsuDlHnS19hptAYZTR8vzupQks1XuQdfE=
User-Agent: KMail/1.9.3
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34651>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GviVt-0007Ls-9N for gcvg-git@gmane.org; Sun, 17 Dec
 2006 00:00:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422757AbWLPXAK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 18:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422758AbWLPXAK
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 18:00:10 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:42158 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1422757AbWLPXAH (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec
 2006 18:00:07 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1171014uga for
 <git@vger.kernel.org>; Sat, 16 Dec 2006 15:00:06 -0800 (PST)
Received: by 10.67.21.11 with SMTP id y11mr2432921ugi.1166310006175; Sat, 16
 Dec 2006 15:00:06 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107]) by
 mx.google.com with ESMTP id i39sm6736815ugd.2006.12.16.15.00.05; Sat, 16 Dec
 2006 15:00:05 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

This is yet another series of planned gitweb features. This part
concentrates on improving gitweb rather than on adding new features.
Comments appreciated.

Copy send to Kernel.Org admin (which probably is most interested
in improving gitweb and git performance), and to Petr Baudis which
maintains repo.or.cz public git hosting site, which runs new(est)
version of gitweb.

1. Cleanup

* HTML cleanup.

  There are still some places where we use presentational HTML elements
  like <i>. I'd rather have it replaced by adding class to appropriate
  element, and adding proper rule to CSS. This would make changing the
  style easier, but it would make generated page larger.

  On the other hand we use class element when sometimes id attribute would
  be better, and sometimes (in the tables) it would be better served to
  add <col> and <colgroup> elements, and use header attribute and select
  CSS style by this attribute value.

* CSS cleanup.

  Use descendant selectors more, and use other selectors like parent or
  grandchild, instead of relying on class, to remove some of redundancy in
  CSS file. This would make ading similar elements easier (for example
  README for a project has now wrong style), and most probably would make
  CSS style smaller.

  Perhaps we should reorder CSS file, and add some comments, to make it's
  maintenance easier, and make it easier to add style for new elements.

* Code cleanup.

  There is still a bit of code cleanup, especially in the subroutines
  which were not refactored yet. For example git_search should take
  advance of git-rev-list / git-log --grep, --author and --committer
  options, and split search output into pages. Untabify should perhaps be
  moved to esc_html, now that esc_path is separated... or perhaps not.


2. Performance etc.

* Better support for mod_perl in "CGI mode". Planned support for mod_perl
  in handler mode and support for FastCGI via CGI::Fast.

  Add support for mod_perl so it wouldn't need to be run with
  +ParseHeaders, and wouldn't need to set CGI environment variables. This
  can speed up gitweb a bit under mod_perl. The problem is how to do this
  to be able to run gitweb under CGI, FastCGI, mod_perl 1.0 and 2.0.

  This includes separating generating HTTP headers into separate
  subroutine, at first thin wrapper around "print $cgi->header(...)".

* Native config reading.

  This could speed up gitweb a bit at least in configurations where
  repository is allowed to override default features (like blame,
  snapshot, pickaxe) and sometimes change their options.

  It would also allow to move some gitweb configuration, like description,
  homepage (in repo.or.cz), cloneurl from separate loose files in $GIT_DIR
  of a repository to it's proper place in the config. I'd rather add
  category as gitweb.category configuration variable than as yet another
  file in .git. Without native config reading it would be hard to add
  sensibly configureable committags support.

  The problem lies with lack of formal description of config file, and in
  git specific additions which make ready modules for INI config parsing
  infeasible. But it is not insurmountable. I think that config reader
  should be then incorporated in Git.pm module. We for sure need some
  tests for it added.

  By the way, should we always parse whole config file like in
  Tie::Memoize? Or read only one variable, if tieing it to hash then with
  Tie::Hash? Or some combination of both?

* Cache validation and infinite cache for unchanging pages

  By itself cache validation would not bring much performance boost (for
  gitweb installations with large traffic), but with the reverse proxy,
  aka. caching engine, aka. HTTP accelerator in front of server this could
  help a lot.

  This means sending proper Last-Modifed: and ETag: (if HTTP/1.1) headers,
  and checking If-Modified-Since: and If-None-Match: headers, replying
  with 304 Not Modified. This should work both with gitweb called both as
  CGI script, and from mod_perl. While at it we should return always only
  HTTP header, without generating (if possible) and writing any contents
  on HEAD requests (and other which do not need body).

  The idea is to use query string (current arguments) with all hashes
  replaced by it's current value as sha1 for ETag, and to use committer
  date for Last-Modified. If possible, we could use stat info: date of
  last modification of given "loose" ref, or packed refs file, although
  that might be inaccurate. Not always we can check if cache is valid
  without calling any git command, but usually we would be able to do this
  after only a few commands. Implementing cache validation might mean that
  we would have to restructure code a bit.

  Separate subroutine for HTTP headers generation would help with writing
  cache validation.

  Bundled together is using "infinite" (or at least large: currently we
  use +1d) Expires: and/or Cache-Control: max-age (if HTTP/1.1) for
  unchanging pages. Although those pages are usually rarely accessed...


Next parts: new features, improving existing views etc. in next email.

-- 
Jakub Narebski
