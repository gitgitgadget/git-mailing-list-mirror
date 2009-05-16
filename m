From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 00/11] http*: refactor fetching code
Date: Sat, 16 May 2009 11:50:42 +0800
Message-ID: <20090516115042.b77829fb.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 16 05:55:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5Azh-0005Yq-0N
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 05:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755673AbZEPDzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 23:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754622AbZEPDzL
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 23:55:11 -0400
Received: from mail-pz0-f115.google.com ([209.85.222.115]:61221 "EHLO
	mail-pz0-f115.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453AbZEPDzK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 23:55:10 -0400
Received: by pzk13 with SMTP id 13so1344167pzk.33
        for <git@vger.kernel.org>; Fri, 15 May 2009 20:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=cvcl2V+gGUZaIa+Bhl/9RI8vHPgWL++uAqshmKAwaes=;
        b=X/zCAwcHVBUch7NQaAvSCo+Dpmirbb2lXlGg067GNYweOxMloeD/iRkVIlIcap6YFj
         25a+6KeaPMZqhGwxC1+03w/Ix76shz3141YH5UmaOFJCDjlewKJpgp4nect56eGlf9Or
         BJ8fI7L4t4REN4WExT6J26zuQ/URr7qsW4dfg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        b=qbwBw9l36xQlAobILrE/AWHmWBirz4UCndb8V9w1eIYjdKIBw5mDNTRO07mKPohVnN
         ASe8tsZZCStGGKEf9pABGZG4eg2RJAJHCIlhr488vXBU3fcHXctQ1WpLJbjDZL2zFNla
         uaq7xk6/pG5vWjMlbtHuOidYk/0P3CaNSGyW0=
Received: by 10.114.240.13 with SMTP id n13mr6061893wah.81.1242446110865;
        Fri, 15 May 2009 20:55:10 -0700 (PDT)
Received: from your-cukc5e3z5n (cm112.zeta149.maxonline.com.sg [116.87.149.112])
        by mx.google.com with ESMTPS id k35sm2177146waf.57.2009.05.15.20.55.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 May 2009 20:55:10 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119322>

This patch series moves out fetching code from http-push.c and
http-walker.c into http.c to reduce code duplicity, and does not
attempt to change git's behaviour.

Patch #1 adds rigour to http fetch tests by testing fetching of packed
objects, in an effort to ensure that this patch series does not break
functionality or change behaviour.

Patch #2 introduces some style fixes, to reduce the number of trivial
differences between http-push.c and http-walker.c.

Patch #3 and #5 add features and fixes that were applied on to fetching
code in http-push.c or http-walker.c, but not the other. Patch #4, like
patch #3, applies onto the code for fetching pack indices (pack-*.idx),
and fixes the issue of "mutating" value of the hex variable in
fetch_index (especially likely to be encountered when using
http-walker.c).

Patch #6 does some simple refactoring of variables and macros.

Patch #7 refactors the logic for appending slashes in quote_ref_url,
creating a new method, end_url_with_slash. The latter method will be
used in the following patches, since the base urls in http-walker.c and
http-push.c are handled differently (ie. the former doesn't include a
trailing slash, while the latter does). By using this method
throughout, fetching code need not use different printf formatters or
differentiate between invocations from http-push.c and http-walker.c.

Patch #8 to #11 refactors code that handles fetching of:
 *pack indices (pack-*.idx)
 *packs
 *pack index (objects/info/packs)
 *loose objects

Tay Ray Chuan (11):
  t5550-http-fetch: test fetching of packed objects
  http-push, http-walker: style fixes
  http-walker: verify remote packs
  http*: copy string returned by sha1_to_hex
  http-push: do not SEGV after fetching a bad pack idx file
  http*: move common variables and macros to http.[ch]
  http: create function end_url_with_slash
  http*: add fetch_http_pack_index
  http*: add helper methods for fetching packs
  http*: add helper methods for fetching objects/info/packs
  http*: add helper methods for fetching objects (loose)

 http-push.c           |  472 +++++-------------------------------------
 http-walker.c         |  525 +++++++++-------------------------------------
 http.c                |  554 ++++++++++++++++++++++++++++++++++++++++++++++++-
 http.h                |   73 +++++++
 t/t5550-http-fetch.sh |    8 +
 5 files changed, 779 insertions(+), 853 deletions(-)
