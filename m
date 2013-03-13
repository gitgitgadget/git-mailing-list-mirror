From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Tag peeling peculiarities
Date: Wed, 13 Mar 2013 16:34:25 +0100
Message-ID: <51409C81.2010200@alum.mit.edu>
References: <51409439.5090001@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 13 16:34:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFnhh-0003l8-Mn
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 16:34:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933848Ab3CMPeb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 11:34:31 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:56716 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932391Ab3CMPe3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Mar 2013 11:34:29 -0400
X-AuditID: 1207440e-b7f2b6d00000094c-25-51409c84a3c2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id A9.B6.02380.48C90415; Wed, 13 Mar 2013 11:34:28 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r2DFYQZ4008160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 13 Mar 2013 11:34:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
In-Reply-To: <51409439.5090001@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqNsyxyHQ4McGE4uuK91MFg29V5gd
	mDwuXlL2+LxJLoApitsmKbGkLDgzPU/fLoE749uLKUwFvbwVF68LNjBu5Opi5OSQEDCRmNbz
	iBXCFpO4cG89WxcjF4eQwGVGifk97xlBEkICx5kkuhsrQWxeAW2JU88+AhVxcLAIqEq8WiQF
	EmYT0JVY1NPMBGKLCoRJvFyygw2iXFDi5MwnLCC2CFDNrmdXweLMAmoSh5Y8AhsvDGSvnvoc
	apW2REPrSmYQm1NAR2L/pH8sEPU6Eu/6HjBD2PIS29/OYZ7AKDALyYpZSMpmISlbwMi8ilEu
	Mac0Vzc3MTOnODVZtzg5MS8vtUjXWC83s0QvNaV0EyMkRPl2MLavlznEKMDBqMTDu6PDIVCI
	NbGsuDL3EKMkB5OSKG/wLKAQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd7luUA53pTEyqrUonyY
	lDQHi5I4r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IEb+BsoEbBotT01Iq0zJwShDQTByfIcC4p
	keLUvJTUosTSkox4UJTGFwPjFCTFA7Q3HaSdt7ggMRcoCtF6ilGXY/e7Ry8YhVjy8vNSpYAu
	ACkSACnKKM2DWwFLSK8YxYE+FuY1BqniASYzuEmvgJYwgSzJsQdZUpKIkJJqYPTKbYjlu/JV
	W/Wa6uyQzJv7am32TVtVzDW5P4ghQ+jU0k9rfku+KJ/aqXYnd1EOi6F2WWCV8Yf5E+S2uAYt
	fbD6t1zTgh9JpySX7du50zP3l7mn1OeXbUtWiP/hdam3kw3ZoXdbJHalkatDmMzX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218059>

On 03/13/2013 03:59 PM, Michael Haggerty wrote:
> I have been working on the pack-refs code [1] and noticed what looks
> like a problem with the handling of peeled refs in the packed-refs file
> and in the reference cache.  In particular, the peeled versions of tags
> outside of refs/tags are *not* stored in packed-refs, but after the
> packed-refs file is read it is assumed that such tags cannot be peeled.
> 
> It is clear that annotated tags want to live under refs/tags, but there
> are some ways to create them in other places (see below).  It is not
> clear to me whether the prohibition of tags outside of refs/tags should
> be made more airtight or whether the peeling of tags outside of
> refs/tags should be fixed.
> 
> Example:
> [...]

I should have mentioned that I already understand the programmatic
*cause* of the behavior that I described in my last email:

* in pack-refs.c:handle_one_ref(), tags that are not in refs/tags are
  explicitly excluded from being peeled.

* in refs.c:read_packed_refs(), if the packed-refs file starts with

      "# pack-refs with: peeled "

  then the REF_KNOWS_PEELED bit is set on *every* reference read from
  the file into the packed refs cache, whether or not it is under
  refs/tags.

* in refs.c:peel_ref(), if a refs cache entry has its REF_KNOWS_PEELED
  bit set but its peeled field is empty, then it is assumed that the
  reference is unpeelable.

What I am *not* clear about is which of these steps is incorrect, and
also whether this problem will have any significant ill effects.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
