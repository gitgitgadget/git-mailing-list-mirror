From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH v3 0/10] getcwd without PATH_MAX
Date: Mon, 28 Jul 2014 20:21:22 +0200
Message-ID: <53D694A2.8030007@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 28 20:22:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBpYj-0000qV-PK
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 20:22:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbaG1SWA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jul 2014 14:22:00 -0400
Received: from mout.web.de ([212.227.17.12]:55678 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708AbaG1SV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 14:21:59 -0400
Received: from [192.168.178.27] ([79.253.140.83]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0Lk8t4-1We9hC2BII-00c9pf; Mon, 28 Jul 2014 20:21:36
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
X-Provags-ID: V03:K0:nSI2+1nYzYXiN6xE9my2Ro9W658+6pjuCrh8wCCACC8ZrCzohnD
 zne+qvfioS5rew2vkZM8ei4FzCT1ayiWAEFLN/Y+lxJwcAE6N9dgFwMXHLaLgYx7wegwu4s
 lICqZWKyR9hJz+gHlgN8IWk+otbPqkUmRkEhUb8l2RlM2VqyNRhNWmnwVCnjcXdKe3SwIeG
 5fVhfVfid+5b0jbR3UhLQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254333>

Paths longer than PATH_MAX can be created and used on at least on some
file systems.  Currently we use getcwd() generally with a PATH_MAX-
sized buffer.  This series adds two functions, strbuf_getcwd() and
xgetcwd(), then uses them to reduce the number of fixed-sized buffers
and to allow us to handle longer working directory paths.

Changes in v3:
  * all getcwd() calls are converted
  * the two strbuf_getcwd() examples from last round use xgetcwd()
    now, as suggested by Jeff
  * strbuf_add_absolute_path() is introduced

Ren=C3=A9 Scharfe (10):
  strbuf: add strbuf_getcwd()
  unix-sockets: use strbuf_getcwd()
  setup: convert setup_git_directory_gently_1 et al. to strbuf
  abspath: use strbuf_getcwd() to remember original working directory
  abspath: convert real_path_internal() to strbuf
  wrapper: add xgetcwd()
  use xgetcwd() to get the current directory or die
  use xgetcwd() to set $GIT_DIR
  abspath: convert absolute_path() to strbuf
  use strbuf_add_absolute_path() to add absolute paths

 Documentation/technical/api-strbuf.txt |  10 +++
 abspath.c                              | 124 +++++++++----------------=
--------
 builtin/init-db.c                      |  24 +++----
 builtin/rev-parse.c                    |   6 +-
 dir.c                                  |  12 ++--
 exec_cmd.c                             |   6 +-
 git-compat-util.h                      |   1 +
 git.c                                  |  13 ++--
 setup.c                                |  91 ++++++++++++------------
 sha1_file.c                            |   2 +-
 strbuf.c                               |  46 ++++++++++++
 strbuf.h                               |   3 +
 trace.c                                |   7 +-
 unix-socket.c                          |  14 ++--
 wrapper.c                              |   8 +++
 15 files changed, 190 insertions(+), 177 deletions(-)

--=20
2.0.2
