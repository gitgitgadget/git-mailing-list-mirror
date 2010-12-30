From: Yann Dirson <ydirson@free.fr>
Subject: Re: [PATCH v6] generalizing sorted-array handling
Date: Thu, 30 Dec 2010 01:01:19 +0100
Message-ID: <20101230000119.GA6639@home.lan>
References: <1291848695-24601-1-git-send-email-ydirson@altern.org>
 <7vd3p9b4d1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 30 01:02:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PY5yT-0001gs-U6
	for gcvg-git-2@lo.gmane.org; Thu, 30 Dec 2010 01:02:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754221Ab0L3AB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Dec 2010 19:01:27 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:56835 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752079Ab0L3AB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Dec 2010 19:01:27 -0500
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 59C5FD48085;
	Thu, 30 Dec 2010 01:01:20 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PY5xH-0002ca-5t; Thu, 30 Dec 2010 01:01:19 +0100
Content-Disposition: inline
In-Reply-To: <7vd3p9b4d1.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164341>

On Fri, Dec 10, 2010 at 03:22:18PM -0800, Junio C Hamano wrote:
> Yann Dirson <ydirson@altern.org> writes:
> 
> > ... I want to get my focus back to
> > bulk-rename/builk-rm patches, which will make heavy use of this API.
> 
> Final comment.  As the primary thing you want to use this is to change the
> way how the rename_dst/rename_src tables are managed, and these are both
> tables sorted by a string, I suspect a more reasonable might be to first
> updated them to use string-list API and add to that API whatever necessary
> features you might need, if any.

It sounds reasonable to build on existing stuff (furthermore, the
string-list binary search is one I had missed).

Using string-lists here however will imply some tradeofs:

* the additional char* pointer in every list element is possibly not
  so high a price to pay

* using the "util" pointer for the payload will make memory management
  even more hairy (eg. "util" as a pointer to a struct which contains
  a pointer to a diff_filespec).  Convenience wrappers will be highly
  needed, and will also be required to keep calls to lookup/insert
  readable, when the elements we deal with are not strings but indeed
  the "util" stuff.

All in all, looks that the data-structure needed should have a higher
focus on the "util" field than string-list has.

Features that seem to miss from string-list today (for the
"dir-rename" series) include:

* custom string-comparison function (ie. prefix comparison): that
  would not be so difficult to generalize by adding a cmp_func
  parameter to get_entry_index().  That would imply changing
  widely-used API funcs like string_list_lookup() to shallow wrappers
  around variants that also take a cmp_func argument.

* lists indexed by 2 strings (bulkmove_candidates): could be replaced
  by using string-lists of string-lists instead, but I'm not sure the
  result would be that great


I still have mixed feelings about all of this.

-- 
Yann
