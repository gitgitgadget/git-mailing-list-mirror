From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 04/12] refs: implement simple transactions for the
 packed-refs file
Date: Thu, 20 Jun 2013 19:58:15 +0200
Message-ID: <51C342B7.5050002@alum.mit.edu>
References: <1371628293-28824-1-git-send-email-mhagger@alum.mit.edu> <1371628293-28824-5-git-send-email-mhagger@alum.mit.edu> <7vfvwdzz6k.fsf@alter.siamese.dyndns.org> <51C2B41F.2050708@alum.mit.edu> <7vd2rgwvvd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 19:58:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upj7x-0003uK-Gs
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 19:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755545Ab3FTR6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 13:58:20 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:49690 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751863Ab3FTR6T (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Jun 2013 13:58:19 -0400
X-AuditID: 1207440e-b7f0f6d0000043b7-5f-51c342bba005
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id D6.D7.17335.BB243C15; Thu, 20 Jun 2013 13:58:19 -0400 (EDT)
Received: from [192.168.69.140] (p57A25408.dip0.t-ipconnect.de [87.162.84.8])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5KHwFLh025838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 20 Jun 2013 13:58:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <7vd2rgwvvd.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsUixO6iqLvb6XCgwZ0v/BZdV7qZLBp6rzBb
	zLu7i8niR0sPs8XuaQvYHFg9Lr38zubxrHcPo8fFS8oejyeeYPX4vEkugDWK2yYpsaQsODM9
	T98ugTtj86ewghMcFet2bGJsYPzB1sXIySEhYCLR+H4dO4QtJnHh3nqgOBeHkMBlRomO3W8Y
	IZyzTBLfXj5g7mLk4OAV0Jb4+KAOpIFFQFVi4v/7YM1sAroSi3qamUBsUYEwiffLprKC2LwC
	ghInZz5hAbFFBNQkJrYdYgGZySzQyShxc+FPRpCEsECMRMPfG2DNQgIfGSXa3kaC2JwCZhIP
	Fx4Bq2EW0JF41wdyA4gtL7H97RzmCYwCs5DsmIWkbBaSsgWMzKsY5RJzSnN1cxMzc4pTk3WL
	kxPz8lKLdI31cjNL9FJTSjcxQkKcbwdj+3qZQ4wCHIxKPLwBSocDhVgTy4orcw8xSnIwKYny
	vnAACvEl5adUZiQWZ8QXleakFh9ilOBgVhLhlVYAyvGmJFZWpRblw6SkOViUxHnVlqj7CQmk
	J5akZqemFqQWwWRlODiUJHgzHIEaBYtS01Mr0jJzShDSTBycIMO5pESKU/NSUosSS0sy4kGR
	Gl8MjFWQFA/QXguQdt7igsRcoChE6ylGXY4DP7a8ZxRiycvPS5US560AKRIAKcoozYNbAUto
	rxjFgT4W5o0CqeIBJkO4Sa+AljABLdmz+hDIkpJEhJRUA6Np6hbzifa3o02bKsWUGxo1LS/F
	Nh4z2HelXbDXYm3o9llWH75xbGX7817dsFL9ad7cOfGPTkoyNxiJzuAIOtbyb+vj 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228516>

On 06/20/2013 07:11 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> But currently only the main packed ref cache can be locked, so it would
>> be possible for lock_packed_refs() to use the static packlock instance
>> for locking.
> 
> Perhaps I am missing something from the previous discussions, but I
> am having trouble understanding the "main packed ref cache" part of
> the above.  "main" as opposed to...?

"main" as opposed to "submodule".

> Is it envisioned that later
> somebody can lock one subpart while another can lock a different and
> non-overlapping subpart, to make changes independently, and somehow
> their non-overlapping changes will be consolidated into a single
> consistent result?

No, the scenario would be that a git process wants to change a reference
in a submodule directly, as opposed to starting another git process
within the submodule, as I believe is done now.  Maybe it's too
far-fetched even to consider...

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
