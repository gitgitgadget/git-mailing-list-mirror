From: "Kelly F. Hickel" <kfh@mqsoftware.com>
Subject: Question about fixing windows bug reading graft data
Date: Mon, 8 Jun 2009 12:19:37 -0500
Message-ID: <63BEA5E623E09F4D92233FB12A9F794303117E06@emailmn.mqsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 08 19:19:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDiVk-0002ep-0c
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 19:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbZFHRTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 13:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbZFHRTh
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 13:19:37 -0400
Received: from mail.de.mqsoftware.com ([66.192.70.108]:7348 "EHLO
	emailmn.mqsoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784AbZFHRTg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2009 13:19:36 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Question about fixing windows bug reading graft data
Thread-Index: AcnoXU0XuqTBhzgZRw2U6H6CLjOnfA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121089>

Hi All,
	Ran into a bug trying to use grafts on windows with cygwin git
version 1.6.1.2.  I've verified that the bug is still there in the
latest source, and was going to submit a patch, but then I noticed that
there seem to be more occurrences in commit.c, and wondered if there was
a better way to fix it than what I had first come up with.

The bug, is that in in commit.c, the code strips '\n', but not '\r', so
the code says the graft data is bad:
struct commit_graft *read_graft_line(char *buf, int len) {
        /* The format is just "Commit Parent1 Parent2 ...\n" */
        int i;
        struct commit_graft *graft = NULL;

        if (buf[len-1] == '\n')
                buf[--len] = 0;
        if (buf[0] == '#' || buf[0] == '\0')
                return NULL;
        if ((len + 1) % 41) {
        bad_graft_data:
                error("bad graft data: %s", buf);
                free(graft);
                return NULL;
        }

My first plan was to fix it the way that xdiff-interface.c handles it,
assuming that was "the Git way" to deal with CRLF:
        /* Exclude terminating newline (and cr) from matching */
        if (len > 0 && line[len-1] == '\n') {
                if (len > 1 && line[len-2] == '\r')
                        len -= 2;
                else
                        len--;
        }

But I noticed that there seemed to be several checks for '\n' in
commit.c that didn't check for '\r', and wondered if there was a reason,
or if there'd be a better way to handle it.....



--
 
Kelly F. Hickel
Senior Product Architect
MQSoftware, Inc.
952-345-8677 Office
952-345-8721 Fax
kfh@mqsoftware.com
www.mqsoftware.com
Certified IBM SOA Specialty
Your Full Service Provider for IBM WebSphere Learn more at
www.mqsoftware.com 
