From: Andrew Myrick <amyrick@apple.com>
Subject: git-svn: persistent memoization
Date: Tue, 19 Jan 2010 15:37:01 -0800
Message-ID: <26542E21-CAF5-4ACD-B9DC-1981AE41F50C@apple.com>
Mime-Version: 1.0 (Apple Message framework v1133)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Sam Vilain <sam@vilain.net>, Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 00:37:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXNdQ-0001CV-Mg
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 00:37:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753434Ab0ASXhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 18:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752321Ab0ASXhF
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 18:37:05 -0500
Received: from mail-out3.apple.com ([17.254.13.22]:57373 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234Ab0ASXhE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jan 2010 18:37:04 -0500
Received: from relay16.apple.com (relay16.apple.com [17.128.113.55])
	by mail-out3.apple.com (Postfix) with ESMTP id 7571880CA811;
	Tue, 19 Jan 2010 15:37:02 -0800 (PST)
X-AuditID: 11807137-b7bd4ae000000f0d-7b-4b56421eb54a
Received: from agility.apple.com (agility.apple.com [17.201.24.116])
	(using TLS with cipher AES128-SHA (AES128-SHA/128 bits))
	(Client did not present a certificate)
	by relay16.apple.com (Apple SCV relay) with SMTP id 6B.E7.03853.E12465B4; Tue, 19 Jan 2010 15:37:02 -0800 (PST)
X-Mailer: Apple Mail (2.1133)
X-Brightmail-Tracker: AAAAAQAAAZE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137502>

git-svn uses the Memoize perl module to cache the return values of a few functions.  This speeds up svn:mergeinfo processing considerably, but as currently implemented, this memoization table must be reconstructed on every run of git-svn.  This isn't a problem on small projects, but it introduces a delay of several minutes when fetching from large repositories with a lot of merge info.

The Memoize module has support for storing its cache persistently (more below, and see http://perldoc.perl.org/Memoize.html for details), and I would love to take advantage of this support in git-svn.  Unfortunately, it's not entirely obvious to me how to get this working.  Here are the questions I have so far, moving from high level design questions to implementation details:

1) Is there any reason not to store these caches on disk?

2) Are there situations where the caches would need to be invalidated?  Perhaps when git-svn rebuilds its metadata?

3) Where should I put these caches?  I was thinking something like ".git/svn/caches/<cachefile>.db" would be appropriate.

4) What's the correct way to reference the path to those caches?  I tried using "$ENV{GIT_DIR}/svn/caches/has_no_changes.db", but the memoize calls are in a BEGIN block, and it seems that $ENV{GIT_DIR} hadn't been initialized at that point.  This has taken me way past my limited knowledge of Perl.

5) What backend should I pick to store the cache?  Memoize supports storing to any tied hash that supports TIEHASH, FETCH, STORE, and EXISTS, like DB_File.  It also supports storing to SDBM_File and NDBM_File through glue modules (they lack EXISTS support), and Storable, which isn't a tied hash at all, but just a serializer for hashes.  I'm leaning towards using Storable since it seems simple and would fit the workload well, but I would appreciate any insight from someone with more domain knowledge here.

Regards,
Andrew