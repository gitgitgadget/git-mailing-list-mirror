From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [3/5] Add http-pull
Date: Fri, 22 Apr 2005 16:34:35 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F03541C6E@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Brad Roberts" <braddr@puremagic.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 23 01:32:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP7co-0006VY-Ef
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 01:31:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbVDVXg3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 19:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVDVXg3
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 19:36:29 -0400
Received: from fmr14.intel.com ([192.55.52.68]:39567 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S261321AbVDVXgX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 19:36:23 -0400
Received: from fmsfmr100.fm.intel.com (fmsfmr100.fm.intel.com [10.1.192.58])
	by fmsfmr002.fm.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j3MNYbvJ032340;
	Fri, 22 Apr 2005 23:34:37 GMT
Received: from fmsmsxvs041.fm.intel.com (fmsmsxvs041.fm.intel.com [132.233.42.126])
	by fmsfmr100.fm.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id j3MNYG7O009407;
	Fri, 22 Apr 2005 23:34:37 GMT
Received: from fmsmsx332.amr.corp.intel.com ([132.233.42.148])
 by fmsmsxvs041.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2005042216343627583
 ; Fri, 22 Apr 2005 16:34:36 -0700
Received: from fmsmsx311.amr.corp.intel.com ([132.233.42.214]) by fmsmsx332.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 22 Apr 2005 16:34:36 -0700
Received: from scsmsx401.amr.corp.intel.com ([10.3.90.12]) by fmsmsx311.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 22 Apr 2005 16:34:36 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [3/5] Add http-pull
Thread-Index: AcVHjxXBu/3y4bz3RG+DvmbpDTHIRQAAedvg
To: "Daniel Barkalow" <barkalow@iabervon.org>,
	"Petr Baudis" <pasky@ucw.cz>
X-OriginalArrivalTime: 22 Apr 2005 23:34:36.0345 (UTC) FILETIME=[D83B3290:01C54793]
X-Scanned-By: MIMEDefang 2.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


>But if you download 1000 files of the 1010 you need, and then your network
>goes down, you will need to download those 1000 again when it comes back,
>because you can't save them unless you have the full history. 

So you could make the temporary object repository persistant between pulls
to avoid reloading them across the wire.  Something like:

get_commit(sha1)
{
	if (sha1 in real_repo) -> done
	if (!(sha1 in tmp_repo))
		load sha1 to tmp_repo
	get_tree(sha1->tree)
	for each parent
		get_commit(sha1->parent)
	move sha1 from tmp_repo to real_repo
}

get_tree(sha1)
{
	if (sha1 in real_repo) -> done
	if (!(sha1 in tmp_repo))
		load sha1 to tmp repo
	for_each (sha1->entry) {
	  case blob: if (!sha1 in real_repo) load to real_repo
	  case tree: get_tree()
	}
	move sha1 from tmp_repo to real_repo
}

The "load sha1 to xxx_repo" needs to be smarter than my dumb wget
based script ... it must confirm the sha1 of the object being loaded
before installing (even into the tmp_repo).

-Tony
	
