From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 15/33] refs: change the internal reference-iteration API
Date: Tue, 16 Apr 2013 15:27:14 +0200
Message-ID: <516D51B2.8090007@alum.mit.edu>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu> <1365944088-10588-16-git-send-email-mhagger@alum.mit.edu> <7vvc7nvglw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Heiko Voigt <hvoigt@hvoigt.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 15:27:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US5uz-0007dl-B8
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 15:27:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754843Ab3DPN1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 09:27:18 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:50667 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753783Ab3DPN1S (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Apr 2013 09:27:18 -0400
X-AuditID: 1207440c-b7ff06d0000008f7-f2-516d51b5d9aa
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 3D.EF.02295.5B15D615; Tue, 16 Apr 2013 09:27:17 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3GDRFQ5028253
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 16 Apr 2013 09:27:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7vvc7nvglw.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsUixO6iqLs1MDfQYOE0SYuuK91MFg29V5gt
	Vj6+y2zxo6WH2YHFo/39O2aPZ717GD0uXlL2+LxJLoAlitsmKbGkLDgzPU/fLoE748xy1YJG
	oYpnO3ewNjCe4Oti5OCQEDCRmNZR18XICWSKSVy4t56ti5GLQ0jgMqPEhf7dTBDOcSaJ+R1v
	mUGqeAW0JRYcXswCYrMIqErs3HCZHcRmE9CVWNTTzARiiwqESaxavwyqXlDi5MwnYPUiAmoS
	E9sOsYAsZhaIkTh3VQjEFBbwkTjdbA6xagWjxJ7XW5hA4pwCZhLffpWCdDIL6Ei863vADGHL
	S2x/O4d5AqPALCQLZiEpm4WkbAEj8ypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXUO93MwSvdSU
	0k2MkEDm2cH4bZ3MIUYBDkYlHt4A+ZxAIdbEsuLK3EOMkhxMSqK8Vp65gUJ8SfkplRmJxRnx
	RaU5qcWHGCU4mJVEeM86AuV4UxIrq1KL8mFS0hwsSuK8qkvU/YQE0hNLUrNTUwtSi2CyMhwc
	ShK8cwKAGgWLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJBMRpfDIxSkBQP0N77IO28
	xQWJuUBRiNZTjLocK688ec0oxJKXn5cqJc7bA1IkAFKUUZoHtwKWtl4xigN9LMx7DKSKB5jy
	4Ca9AlrCBLTkwKpskCUliQgpqQbG6giFt/80rjDE8GqaH+7ln9P5/2bMvyyvtBfubdtfTKk8
	cTkvK0V66aqNmrsmeSzQYg01cr4hdfDMNPP3sWX8Lir7Tj7e6P51iVGNtO/treEx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221415>

On 04/15/2013 07:38 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> [...]  But more
>> importantly, this change prevents peel_ref() from returning invalid
>> results in the following scenario:
>>
>> When iterating via the external API, the iteration always includes
>> both packed and loose references, and in particular never presents a
>> packed ref if there is a loose ref with the same name.  The internal
>> API, on the other hand, gives the option to iterate over only the
>> packed references.  During such an iteration, there is no check
>> whether the packed ref might be hidden by a loose ref of the same
>> name.  But until now the packed ref was recorded in current_ref during
>> the iteration.  So if peel_ref() were called with the reference name
>> corresponding to current ref, it would return the peeled version of
>> the packed ref even though there might be a loose ref that peels to a
>> different value.  This scenario doesn't currently occur in the code,
>> but fix it to prevent things from breaking in a very confusing way in
>> the future.
> 
> Hopefully that means "in later patches in this series" ;-)

I don't think that the rest of the series would have triggered this
problem either.  In fact, if I had written repack_without_ref()'s
peeling functionality using peel_ref(), then it would have *depended* on
this bug for its proper operation...otherwise it would have written the
peeled version of the loose ref to the packed-ref file.  Of course, it's
all pretty academic because the peeled version of a packed ref should
never be used when it is overridden by a loose ref, so the incorrect
peeled values in the packed-ref file shouldn't have any observable effects.

The real problem is that calling the old peel_ref() function on a packed
reference was illegitimate because the function only knew how to peel a
ref that was still active.  Plus it's kindof silly tucking away the
current reference in a global variable then looking it up again instead
of passing the ref_entry around.

Callers outside of refs.c could also not have triggered this bug because
they have no way to access overridden packed refs.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
