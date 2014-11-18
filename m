From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 00/14] ref-transactions-reflog
Date: Tue, 18 Nov 2014 12:26:24 +0100
Message-ID: <546B2CE0.6020208@alum.mit.edu>
References: <1416274550-2827-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Nov 18 12:26:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqgvk-0007Zv-2u
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 12:26:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754496AbaKRL0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 06:26:37 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:64883 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754492AbaKRL0f (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Nov 2014 06:26:35 -0500
X-AuditID: 1207440e-f79d26d000001b6e-61-546b2ce3f67b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 1F.89.07022.3EC2B645; Tue, 18 Nov 2014 06:26:27 -0500 (EST)
Received: from [192.168.69.130] (p5DDB3D42.dip0.t-ipconnect.de [93.219.61.66])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sAIBQOmm031636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 18 Nov 2014 06:26:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <1416274550-2827-1-git-send-email-sbeller@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42IRYndR1H2skx1icGCiuEXXlW4mi4beK8wW
	mze3szgweyzYVOpx8ZKyx+dNcgHMUdw2SYklZcGZ6Xn6dgncGScXbWYtmCFdcX9bJ1sD40/R
	LkZODgkBE4lJV48xQ9hiEhfurWfrYuTiEBK4zChx9elxZgjnHJNEb+t6dpAqXgFtiYtXp7F0
	MXJwsAioSnQ1eYCE2QR0JRb1NDOB2KICQRIn91yHKheUODnzCVi5iICfxMxvAiCmsICpRPN2
	RpAKIQFHiQ0vV7OB2JwCThKf1/0G62QW0JPYcf0XK4QtL9G8dTbzBEb+WUiGzkJSNgtJ2QJG
	5lWMcok5pbm6uYmZOcWpybrFyYl5ealFusZ6uZkleqkppZsYIcHJt4Oxfb3MIUYBDkYlHt6E
	qVkhQqyJZcWVuYcYJTmYlER5z6tmhwjxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4T3XDVTOm5JY
	WZValA+TkuZgURLnVVui7ickkJ5YkpqdmlqQWgSTleHgUJLg7dMGGipYlJqeWpGWmVOCkGbi
	4AQZziUlUpyal5JalFhakhEPisb4YmA8gqR4gPaygLTzFhck5gJFIVpPMSpKifOeA0kIgCQy
	SvPgxsJSzitGcaAvhXntgQlIiAeYruC6XwENZgIaPGdDJsjgkkSElFQDo2F/Sez1qLJtIr03
	NjZusqq4trzYsvPtJeG4Uxplu8Sla6wFNvzzeOm9+Jxyp+28uqM39CSuPWI/mOqc0jJF+92K
	R5wTVBZfurYmsP+mlaTXsb9exq62hgy3eXxC7LYmyc0qCKtwPvxAaLP6JCuv/H73 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/18/2014 02:35 AM, Stefan Beller wrote:
> The following patch series updates the reflog handling to use transactions.
> This patch series has previously been sent to the list[1].
> [...]

I was reviewing this patch series (I left some comments in Gerrit about
the first few patches) when I realized that I'm having trouble
understanding the big picture of where you want to go with this. I have
the feeling that the operations that you are implementing are at too low
a level of abstraction.

What are the elementary write operations that are needed for a reflog?
Off the top of my head,

1. Add a reflog entry when a reference is updated in a transaction.
2. Rename a reflog file when the corresponding reference is renamed.
3. Delete the reflog when the corresponding reference is deleted [1].
4. Configure a reference to be reflogged.
5. Configure a reference to not be reflogged anymore and delete any
   existing reflog.
6. Selectively expire old reflog entries, e.g., based on their age.

Have I forgotten any?

The first three should be side-effects of the corresponding reference
updates. Aside from the fact that renames are not yet done within a
transaction, I think this is already the case.

Number 4, I think, currently only happens in conjunction with adding a
line to the reflog. So it could be implemented, say, as a
FORCE_CREATE_REFLOG flag on a ref_update within a transaction.

Number 5 is not very interesting, I think. For example, it could be a
separate API function, disconnected from any transactions.

Number 6 is more interesting, and from my quick reading, it looks like a
lot of the work of this patch series is to allow number 6 to be
implemented in builtin/reflog.c:expire_reflog(). But it seems to me that
you are building API calls at the wrong level of abstraction. Expiring a
reflog should be a single API call to the refs API, and ultimately it
should be left up to the refs backend to decide how to implement it. For
a filesystem-based backend, it would do what it does now. But (for
example) a SQL-based backend might implement this as a single SELECT
statement.

I also don't have the feeling that reflog expiration has to be done
within a ref_transaction. For example, is there ever a reason to combine
expiration with other reference updates in a single atomic transaction?
I think not.

So it seems to me that it would be more practical to have a separate API
function that is called to expire selected entries from a reflog [2],
unconnected with any transaction.

I am not nearly as steeped in this code as you and Ronnie, and it could
be that I'm forgetting lots of details that make your design preferable.
But other reviewers are probably in the same boat. So I think it would
be really helpful if you would provide a high-level description of the
API that you are proposing, and some discussion of its design and
tradeoffs. A big part of this description could go straight into a file
Documentation/technical/api-ref-transactions.txt, which will be a great
(and necessary) resource soon anyway.

Michael

[1] Though hopefully there will be future reference backends that don't
have to discard reflogs when a reference is deleted, so let's not bake
this behavior too fundamentally into the API.

[2] ...and/or possibly one to expire reflogs for multiple references, if
performance would benefit significantly.

-- 
Michael Haggerty
mhagger@alum.mit.edu
