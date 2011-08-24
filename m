From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 6/6] Retain caches of submodule refs
Date: Wed, 24 Aug 2011 13:33:28 +0200
Message-ID: <4E54E188.10802@alum.mit.edu>
References: <1313188589-2330-1-git-send-email-mhagger@alum.mit.edu> <1313188589-2330-7-git-send-email-mhagger@alum.mit.edu> <7v4o1hgemp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 24 13:33:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwBiW-0000nf-UW
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 13:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127Ab1HXLdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 07:33:53 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:45546 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057Ab1HXLdv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 07:33:51 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p7OBXSgu023793
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 24 Aug 2011 13:33:28 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.18) Gecko/20110617 Lightning/1.0b2 Thunderbird/3.1.11
In-Reply-To: <7v4o1hgemp.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179996>

On 08/17/2011 12:45 AM, Junio C Hamano wrote:
> All the changes except for this one made sense to me, but I am not sure
> about this one. How often do we look into different submodule refs in the
> same process over and over again?

As I've mentioned, I am not very familiar with submodules and I don't
know what actions in submodules can be triggered from the top-level
project.  Here is the only code path that I can find in the current git
code that causes submodule refs to be read at all:

setup_revisions() with opt->submodule is set,
    which can only happen when called via merge_submodule(),
    which is called from merge_file() in merge-recursive.c,
    which is called by process_renames() and merge_content(),
    which are both ultimately called from merge_trees().

I don't know how often this can happen during the lifetime of one process.

The cost of retaining the submodule ref caches is roughly 100 bytes per
reference of memory.  Another side effect is that the submodule caches
never have to be cleaned up; this saves a list walk and one free() per
cached reference if the refs for more than one submodule are accessed.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
