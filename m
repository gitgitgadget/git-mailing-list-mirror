From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 00/14] Clean up how fetch_pack() handles the heads list
Date: Sun,  9 Sep 2012 08:19:35 +0200
Message-ID: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 09 08:21:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAatT-0002cs-8H
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 08:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751725Ab2IIGUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 02:20:25 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:63089 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751290Ab2IIGUY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Sep 2012 02:20:24 -0400
X-AuditID: 12074414-b7f846d0000008b8-94-504c3527043a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id CE.84.02232.7253C405; Sun,  9 Sep 2012 02:20:23 -0400 (EDT)
Received: from michael.fritz.box (p57A25CBD.dip.t-dialin.net [87.162.92.189])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q896KIld029164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 9 Sep 2012 02:20:21 -0400
X-Mailer: git-send-email 1.7.11.3
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsUixO6iqKtu6hNgcPSqrkXXlW4mi4beK8wW
	t1fMZ7b40dLDbNE5VdaB1ePv+w9MHsuXrmP0eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M47s72IteMNT8f/4WqYGxjlcXYycHBICJhKr979jg7DFJC7cWw9kc3EICVxmlHj64wIz
	hHOGSeLTjiWMIFVsAroSi3qamUBsEQE1iYlth1hAipgFuhgllq/7BTZKWMBLYsvi9cwgNouA
	qsTb9X3sIDavgItE24+PrBDrFCV+fF/DPIGRewEjwypGucSc0lzd3MTMnOLUZN3i5MS8vNQi
	XQu93MwSvdSU0k2MkCAR2cF45KTcIUYBDkYlHl6mO94BQqyJZcWVuYcYJTmYlER5NUx8AoT4
	kvJTKjMSizPii0pzUosPMUpwMCuJ8F5lB8rxpiRWVqUW5cOkpDlYlMR5vy1W9xMSSE8sSc1O
	TS1ILYLJynBwKEnwfjAGahQsSk1PrUjLzClBSDNxcIIILpANPEAbgkG28xYXJOYWZ6ZDFJ1i
	VJQS55UCSQiAJDJK8+AGwOL5FaM40D/CvCwgVTzAVADX/QpoMBPQYJFnHiCDSxIRUlINjNMa
	NYpne0vNX3JGamPOTEFFZkfn9X7RezrOK+tavXhiI9/UsS3x0vZG5bfbP58qmVS5XFYj4pVH
	3ZvO3+JFnZXp6ldPL1FaUWgbIDJPxvq2ZuniY2LrxW1f+iyOOrl//yy/+ULHHOKCma8Elr7k
	9vv66/aDo3lZz6f+vprq3NRa2uKj5iTOpsRSnJFoqMVcVJwIAFz9luXCAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205052>

This patch series depends on the "Add some string_list-related
functions" series that I just submitted.

This series is a significant rewrite of v2 based on the realization
that the <nr_heads,heads> pair that is passed around in these
functions is better expressed as a string_list.  I hope you will find
that this version is shorter and clearer than its predecessors, even
though its basic logic is mostly the same.

Sorry for the false starts in v1 and v2 and the extra reviewing work
that this will cost.

Michael Haggerty (14):
  t5500: add tests of error output for missing refs
  t5500: add tests of fetch-pack --all --depth=N $URL $REF
  Rename static function fetch_pack() to http_fetch_pack()
  fetch_pack(): reindent function decl and defn
  Change fetch_pack() and friends to take string_list arguments
  filter_refs(): do not check the same sought_pos twice
  fetch_pack(): update sought->nr to reflect number of unique entries
  filter_refs(): delete matched refs from sought list
  filter_refs(): build refs list as we go
  filter_refs(): simplify logic
  cmd_fetch_pack(): return early if finish_connect() fails
  fetch-pack: report missing refs even if no existing refs were
    received
  cmd_fetch_pack(): simplify computation of return value
  fetch-pack: eliminate spurious error messages

 builtin/fetch-pack.c  | 169 +++++++++++++++++++-------------------------------
 fetch-pack.h          |  20 ++++--
 http-walker.c         |   4 +-
 t/t5500-fetch-pack.sh |  47 +++++++++++++-
 transport.c           |  12 ++--
 5 files changed, 130 insertions(+), 122 deletions(-)

-- 
1.7.11.3
