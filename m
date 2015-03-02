From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 0/7] Fix some problems with reflog expiration
Date: Mon,  2 Mar 2015 10:29:50 +0100
Message-ID: <1425288597-20547-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 10:31:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSMgy-0007b3-T8
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 10:31:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753827AbbCBJbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 04:31:08 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:64806 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753752AbbCBJaL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Mar 2015 04:30:11 -0500
X-AuditID: 12074413-f79f26d0000030e7-45-54f42da199fa
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id ED.F9.12519.1AD24F45; Mon,  2 Mar 2015 04:30:09 -0500 (EST)
Received: from michael.fritz.box (p5DDB2321.dip0.t-ipconnect.de [93.219.35.33])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t229U5HT008921
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 2 Mar 2015 04:30:07 -0500
X-Mailer: git-send-email 2.1.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsUixO6iqLtQ90uIQd80BYuuK91MFg29V5gt
	3t5cwmhxe8V8ZovuKW8ZLX609DBb9PZ9YrXYvLmdxeLMm0ZGB06Pv+8/MHnsnHWX3WPBplKP
	Z717GD0uXlL2WPzAy+PzJrkA9ihum6TEkrLgzPQ8fbsE7oxpj5vYCxbwVczvu8bawLiFu4uR
	k0NCwESi9dNFZghbTOLCvfVsILaQwGVGiR/PUrsYuYDsY0wSh688AitiE9CVWNTTzARiiwio
	SUxsO8QCYjML/GCSOLSitouRg0NYwEFi515OkDCLgKrE6gfHWUFsXgEXiauTzrBA7JKTOH/8
	J/MERu4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3TN9XIzS/RSU0o3MUICS3gH466TcocY
	BTgYlXh4F8z7HCLEmlhWXJl7iFGSg0lJlPe4zpcQIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8
	r+WBcrwpiZVVqUX5MClpDhYlcV61Jep+QgLpiSWp2ampBalFMFkZDg4lCd4dIEMFi1LTUyvS
	MnNKENJMHJwgw7mkRIpT81JSixJLSzLiQWEeXwwMdJAUD9DeuyDtvMUFiblAUYjWU4yKUuK8
	3SAJAZBERmke3FhYunjFKA70pTDvX5AqHmCqget+BTSYCWjwLUWwwSWJCCmpBkYlsfDO31Fr
	vQxCA1OTK/uuXGXo2cHK8nbu4dpZF3dsYJcpnbtBnm3R/uu2z5XOZD5OOq7Rv2rjLtGzJ5v3
	ZwYxJYsbXnsi5XPH//qvfTEWUjts3T+/MhToUl+/wOin2MG5qR4puidXf5nlK+7S 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264586>

This is v2 of the patch series. Thanks to Eric Sunshine, Stefan
Beller, Peff, and Junio for their comments about v1 [1].

The two main changes since v1:

* Don't change the locking policy for changing symbolic references.
  Even though the existing policy is partly broken, the change
  proposed in v1 would have introduced an incompatibility with older
  versions of Git and with libgit2 and possibly other Git clients. I
  will try to implement the transition plan described in [2], but I
  will do it in a separate patch series.

* I rewrote the "git reflog" documentation more completely, following
  Junio's suggestion.

Other changes since v1:

* Rebased onto a more recent version of upstream master (because
  master now includes mh/reflog-expire and sb/atomic-push). The rebase
  was conflict-free.

* Tweaked some commit messages and added some Reviewed-by lines.

* Appended a patch by Stefan Beller to delete the "force_write" member
  of "struct ref_lock".

[1] http://thread.gmane.org/gmane.comp.version-control.git/263552
[2] http://article.gmane.org/gmane.comp.version-control.git/263811

Michael Haggerty (6):
  write_ref_sha1(): remove check for lock == NULL
  write_ref_sha1(): Move write elision test to callers
  lock_ref_sha1_basic(): do not set force_write for missing references
  reflog: improve and update documentation
  reflog_expire(): ignore --updateref for symbolic references
  reflog_expire(): never update a reference to null_sha1

Stefan Beller (1):
  struct ref_lock: delete the force_write member

 Documentation/git-reflog.txt | 139 +++++++++++++++++++++++++------------------
 builtin/reflog.c             |   4 +-
 refs.c                       |  63 +++++++++++---------
 3 files changed, 117 insertions(+), 89 deletions(-)

-- 
2.1.4
