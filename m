From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: RFC GSoC idea: git configuration caching (needs co-mentor!)
Date: Thu, 06 Mar 2014 06:57:20 +0100
Message-ID: <53180E40.5050308@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 06 06:57:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLRJD-0006ce-6K
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 06:57:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914AbaCFF50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 00:57:26 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:55530 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751303AbaCFF5Y (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Mar 2014 00:57:24 -0500
X-AuditID: 1207440f-f79326d000003c9f-c8-53180e44c60f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id DD.92.15519.44E08135; Thu,  6 Mar 2014 00:57:24 -0500 (EST)
Received: from [192.168.69.148] (p57A24A5D.dip0.t-ipconnect.de [87.162.74.93])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s265vLs9024928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 6 Mar 2014 00:57:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqOvCJxFs8HoSp0XXlW4mi4beK8wW
	lz6vZ7X40dLD7MDiMfHLcVaPZ717GD0uXlL2+LxJLoAlitsmKbGkLDgzPU/fLoE7o+vXdKaC
	9QIV+9vvMzUw7uTtYuTkkBAwkTjcuoQJwhaTuHBvPVsXIxeHkMBlRolt7xqYIZyzTBKvGl6y
	glTxCmhLbF86nRnEZhFQlfjxYQGYzSagK7GopxlskqhAsMTqyw9YIOoFJU7OfAJmiwDV7Hp2
	lQ3EZhYol1hx9h5YvbCAi8TTGUeAajiArhCX6GkMgijRkXjX94AZwpaX2P52DvMERv5ZSKbO
	QlI2C0nZAkbmVYxyiTmlubq5iZk5xanJusXJiXl5qUW6Jnq5mSV6qSmlmxghYcu/g7Frvcwh
	RgEORiUeXs5A8WAh1sSy4srcQ4ySHExKorwhDBLBQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4
	Hz4BKudNSaysSi3Kh0lJc7AoifOqL1H3ExJITyxJzU5NLUgtgsnKcHAoSfBO5gEaKliUmp5a
	kZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+KyPhiYEyCpHiA9s4CaectLkjMBYpCtJ5i1OW4
	3fbrE6MQS15+XqqUOK8nSJEASFFGaR7cCliSesUoDvSxMO8DkCoeYIKDm/QKaAkT0JJoPpDn
	iksSEVJSDYycdV4T571o9P6zKDFnQdivfeyy17We8S7rV5/iqRJy0lBNpVKBZ7FsraRU/v8D
	wWJ73NhmemiJq/55fPbByohgJrF/cxveMfN5Na09d1757O+VJ5jni0+VnLdxnvX3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243500>

I just wrote up the idea that fell out of the discussion [1] about the
other configuration features that I proposed.  As far as I am concerned,
it can be merged as soon as somebody volunteers as a co-mentor.  The
idea is embodied in a pull request against the git.github.io repository
[2]; the text is also appended below for your convenience.

Michael

[1] http://article.gmane.org/gmane.comp.version-control.git/242952
[2] https://github.com/git/git.github.io/pull/7

### git configuration API improvements

There are many places in Git that need to read a configuration value.
Currently, each such site calls `git_config()`, which reads and parses
the configuration files every time that it is called.  This is
wasteful, because it results in the configuration files being
processed multiple times during a single `git` invocation.  It also
prevents the implementation of potential new features, like adding
syntax to allow a configuration file to unset a previously-set value.

This goal of this project is to make configuration work as follows:

* Read the configuration from files once and cache the results in an
  appropriate data structure in memory.

* Change `git_config()` to iterate through the pre-read values in
  memory rather than re-reading the configuration files.

* Add new API calls that allow the cache to be inquired easily and
  efficiently.  Rewrite other functions like `git_config_int()` to be
  cache-aware.

* Rewrite callers to use the new API wherever possible.

You will need to consider how to handle other config API entry points
like `git_config_early()` and `git_config_from_file()`, as well as how
to invalidate the cache correctly in the case that the configuration
is changed while `git` is executing.

See
[this mailing list
thread](http://article.gmane.org/gmane.comp.version-control.git/242952)
for some discussion about this and related ideas.

 - Language: C
 - Difficulty: medium
 - Possible mentors: Michael Haggerty

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
