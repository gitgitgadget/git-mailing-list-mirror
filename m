From: Dustin Sallings <dustin@spy.net>
Subject: git describe bug?
Date: Fri, 2 Apr 2010 10:20:44 -0700
Message-ID: <0B8BD2B7-E6F9-4EFC-BCD6-2B2E876AD1FC@spy.net>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 02 19:27:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nxkeu-00032E-LE
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 19:27:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755899Ab0DBR1s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 13:27:48 -0400
Received: from adsl-69-230-8-158.dsl.pltn13.pacbell.net ([69.230.8.158]:50319
	"EHLO mail.west.spy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755879Ab0DBR1q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Apr 2010 13:27:46 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Apr 2010 13:27:46 EDT
Received: from [10.17.1.153] (adsl-99-96-18-166.dsl.pltn13.sbcglobal.net [99.96.18.166])
	by mail.west.spy.net (Postfix) with ESMTPA id AD03F7E3F
	for <git@vger.kernel.org>; Fri,  2 Apr 2010 10:21:08 -0700 (PDT)
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143829>


	describe does not choose the most recent tag when multiple tags point to a single commit (for example, when an RC release becomes a proper release).

	There's a bit of conflict in the documentation between the following:

		``tags with newer dates will always be preferred over tags with older dates''

	and the next sentence:

		``If an exact match is found, its name will be output and searching will stop.''

	The code does not allow for multiple exact matches, leading to what I would consider incorrect behavior as shown below:


dhcp-103:/tmp/x 1212% git init
Initialized empty Git repository in /private/tmp/x/.git/
dhcp-103:/tmp/x 1213% git config user.email me@example.com
dhcp-103:/tmp/x 1214% git commit --allow-empty -m initial
[master (root-commit) 7eb97db] initial
dhcp-103:/tmp/x 1215% git commit --allow-empty -m second
[master 86544e0] second
dhcp-103:/tmp/x 1216% git tag -m first 1.0
dhcp-103:/tmp/x 1217% git describe                      # expect 1.0
1.0
dhcp-103:/tmp/x 1218% git tag -m second 2.0
dhcp-103:/tmp/x 1219% git describe                      # expect 2.0
1.0
dhcp-103:/tmp/x 1220% git show-ref 
86544e0414d9d4bc0767eed1ffe36b655638fe81 refs/heads/master
2594a45768685b7fbf69cf2e2fca087cdf3cbfec refs/tags/1.0
175a0473faa32cacff0b42f165d39a9547025432 refs/tags/2.0
dhcp-103:/tmp/x 1221% git cat-file tag refs/tags/1.0
object 86544e0414d9d4bc0767eed1ffe36b655638fe81
type commit
tag 1.0
tagger Dustin Sallings <me@example.com> 1270227996 -0700

first
0.000u 0.001s 0:00.00 0.0%	0+0k 0+0io 0pf+0w
dhcp-103:/tmp/x 1222% git cat-file tag refs/tags/2.0
object 86544e0414d9d4bc0767eed1ffe36b655638fe81
type commit
tag 2.0
tagger Dustin Sallings <me@example.com> 1270228008 -0700

second


-- 
Dustin Sallings
