From: David Turner <dturner@twopensource.com>
Subject: RFC/Pull Request: Refs db backend
Date: Mon, 22 Jun 2015 20:50:56 -0400
Organization: Twitter
Message-ID: <1435020656.28466.8.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 23 02:51:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7CQb-00061J-Tg
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 02:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753413AbbFWAvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 20:51:00 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34299 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793AbbFWAu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 20:50:59 -0400
Received: by qkeo142 with SMTP id o142so92452348qke.1
        for <git@vger.kernel.org>; Mon, 22 Jun 2015 17:50:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:organization
         :content-type:mime-version:content-transfer-encoding;
        bh=Z3bA+8ozjqmrEdn1DV030NpniETYBLziamQMnIzoBv8=;
        b=m8ME8v6fUj18TN07yl84kKlI83LfDNCIkFQQI7mccrBcpbnf/BSgH07zumfDriap1m
         wFuRbu4qN+uVHfew54fTI3zOnpXAlm5B5SLV83xq/5bsX0REemEwfQaq2C05PZj7Jrv8
         BDQRlsr07SUYlaIkEVvfd0shMuxxjqnVrdaX/i6/tG5PZg5zcweMiqUyyJ2a8lCZPJv0
         0Oow/ehd8SzNEkWLW+/pq8wT9/uvxwEch1BbLIUr7aP/h+eavd7tcYlIrHutob8jqk3k
         bQoabTCaxYtew/yqytikUSGTT2lxcrCQt4WXeqETJjvv9mKcn7/HnTABf8JYEW6AlbC3
         WxHw==
X-Gm-Message-State: ALoCoQlnBAHk22lbFGwiOMIG261CxTy7rPGXtiiq8vmJsAbexRDomecT3ga+uJpvdq6vkCT1eqM5
X-Received: by 10.140.48.103 with SMTP id n94mr41042640qga.8.1435020658617;
        Mon, 22 Jun 2015 17:50:58 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by mx.google.com with ESMTPSA id b85sm698133qkb.8.2015.06.22.17.50.57
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2015 17:50:57 -0700 (PDT)
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272438>

I've revived and modified Ronnie Sahlberg's work on the refs db
backend.  

The work is on top of be3c13e5564, Junio's "First batch for 2.5 cycle".
I recognize that there have been changes to the refs code since then,
and that there are some further changes in-flight from e.g. Michael
Haggerty.  If there is interest in this, I can rebase once Michael's
changes land.

The changes can be found here:
https://github.com/dturner-tw/git.git on the dturner/pluggable-backends
branch

The db backend code was added in the penultimate commit; the rest is
just code rearrangement and minor changes to make alternate backends
possible.  There ended up being a fair amount of this rearrangement, but
the end result is that almost the entire git test suite runs under the
db backend without error (see below for details).

The db backend runs git for-each-ref about 30% faster than the files
backend with fully-packed refs on a repo with ~120k refs.  It's also
about 4x faster than using fully-unpacked refs.  In addition, and
perhaps more importantly, it avoids case-conflict issues on OS X.

I chose to use LMDB for the database.  LMDB has a few features that make
it suitable for usage in git:

1. It is relatively lightweight; it requires only one header file, and
the library itself is under 300k (as opposed to 700k for
e.g. sqlite).

2. It is well-tested: it's been used in OpenLDAP for years.

3. It's very fast.  LMDB's benchmarks show that it is among
the fastest key-value stores.

4. It has a relatively simple concurrency story; readers don't
block writers and writers don't block readers.

Ronnie Sahlberg's original version of this patchset used tdb.  The
advantage of tdb is that it's smaller (~125k).  The disadvantages are
that tdb is hard to build on OS X.  It's also not in homebrew.  So lmdb
seemed simpler.

To test this backend's correctness, I hacked test-lib.sh and
test-lib-functions.sh to run all tests under the refs backend. Dozens
of tests use manual ref/reflog reading/writing, or create submodules
without passing --refs-backend-type to git init.  If those tests are
changed to use the update-ref machinery or test-refs-be-db (or, in the
case of packed-refs, corrupt refs, and dumb fetch tests, are skipped),
the only remaining failing tests are the git-new-workdir tests and the
gitweb tests.  

Please let me know how it would be best to proceed. 
