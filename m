From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 5/5] ref_transaction_commit(): only keep one lockfile
 open at a time
Date: Sat, 25 Apr 2015 08:08:28 +0200
Message-ID: <553B2F5C.3010007@alum.mit.edu>
References: <1429875349-29736-1-git-send-email-mhagger@alum.mit.edu> <1429875349-29736-6-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 08:08:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YltGe-0000ZN-Gy
	for gcvg-git-2@plane.gmane.org; Sat, 25 Apr 2015 08:08:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754383AbbDYGIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2015 02:08:39 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:59452 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754326AbbDYGIh (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Apr 2015 02:08:37 -0400
X-AuditID: 1207440c-f79376d00000680a-53-553b2f5f709f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 2E.0A.26634.F5F2B355; Sat, 25 Apr 2015 02:08:31 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB26AD.dip0.t-ipconnect.de [93.219.38.173])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t3P68TFZ028438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 25 Apr 2015 02:08:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <1429875349-29736-6-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsUixO6iqBuvbx1q8Pgzv0XXlW4mi4beK8wW
	P1p6mC02b25ncWDxWLCp1ONZ7x5Gj4uXlD0+b5ILYInitklKLCkLzkzP07dL4M642H+eraBf
	qmLJ24PMDYwPhLsYOTkkBEwkdq7dxwphi0lcuLeerYuRi0NI4DKjRN/u/ywQznkmiSmr5oNV
	8QpoS3x9MoMdxGYRUJV49ugnI4jNJqArsainmQnEFhUIkmi9NpURol5Q4uTMJ0CDODhEBLwk
	2mYWg5jMAkYS807Xg5jCAlES7y4mgBQLCdRKbL66G6yRU8BV4t29aWADmQX0JHZc/8UKYctL
	NG+dzTyBUWAWkvmzkJTNQlK2gJF5FaNcYk5prm5uYmZOcWqybnFyYl5eapGuoV5uZoleakrp
	JkZIIPPsYPy2TuYQowAHoxIP7w0G61Ah1sSy4srcQ4ySHExKorwBb61ChfiS8lMqMxKLM+KL
	SnNSiw8xSnAwK4nwCuoClfOmJFZWpRblw6SkOViUxHlVl6j7CQmkJ5akZqemFqQWwWRlODiU
	JHgZ9YAaBYtS01Mr0jJzShDSTBycIMO5pESKU/NSUosSS0sy4kFRGl8MjFOQFA/Q3jNge4sL
	EnOBohCtpxgVpcR5D4IkBEASGaV5cGNh6ekVozjQl8K8SiDbeYCpDa77FdBgJqDBM5dagAwu
	SURISTUwNjZ9n3Hk6MrmbfElUWdYPwfZcz9QDTKbLHb12sxD3zO2e01Qnrf8t2NsOtuPg2yC
	YjeCdmZZskwK6r5o7Wtkl5BjOl0nc724Db9uf5tF79pLt5vV9SXW8W3KyAs97uN1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267777>

On 04/24/2015 01:35 PM, Michael Haggerty wrote:
> The old code locked all of the references in the first loop, leaving
> all of the lockfiles open until later loops. Since we might be
> updating a lot of references, this could cause file descriptor
> exhaustion.
> 
> But there is no reason to keep the lockfiles open after the first
> loop:
> 
> * For references being deleted or verified, we don't have to write
>   anything into the lockfile, so we can close it immediately.
> 
> * For references being updated, we can write the new SHA-1 into the
>   lockfile immediately and close the lockfile without renaming it into
>   place. In the second loop, the already-written contents can be
>   renamed into place using commit_ref_update().
> 
> To simplify the bookkeeping across loops, add a new REF_NEEDS_COMMIT
> bit to update->flags, which keeps track of whether the corresponding
> lockfile needs to be committed, as opposed to just unlocked.
> 
> This change fixes two tests in t1400.

I realize that I should have highlighted another, perhaps more serious
bug that is fixed by this change. The old code was roughly

    for update in updates:
        acquire locks and check old_sha
    for update in updates:
        if changing value:
            write_ref_to_lockfile()
            commit_ref_update()
    for update in updates:
        if deleting value:
            unlink()
    for update in updates:
        if reference still locked:
            unlock_ref()

The atomicity of the update depends on all preconditions being checked
in the first loop, before any changes have start being committed. The
problem is that write_ref_to_lockfile() (which used to be part of
write_ref_sha1()), which happens in the second loop, checks some more
preconditions:

* It verifies that new_sha1 is a valid object
* If the reference being updated is a branch, it verifies that new_sha1
  points at a commit object (as opposed to a tag, tree, or blob).

If either of these preconditions fails, the "transaction" might be
aborted after some reference updates have already been permanently
committed. In other words, the all-or-nothing promise of "git update-ref
--stdin" and "git push --atomic" would be violated.

I'm sorry that I didn't fully realize this problem earlier.

After this patch, the code looks like

    for update in updates:
        acquire locks and check old_sha
        if changing value:
            write_ref_to_lockfile()
    for update in updates:
        if changing value:
            commit_ref_update()
    for update in updates:
        if deleting value:
            unlink()
    for update in updates:
        if reference still locked:
            unlock_ref()

This has the important effect that the pre-checks in
write_ref_to_lockfile() are carried out before any changes have been
committed, so if any of those checks fail, the transaction can be rolled
back correctly.

Given that "git push --atomic" is one of the main new features of 2.4.0,
it would be unfortunate for the release to contain this bug, plus the
bug that atomic pushes can fail due to file descriptor exhaustion.

Is this problem important enough to justify delaying the release to get
the fix in?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
