From: Greg Price <price@ksplice.com>
Subject: Re: [PATCH] pack-refs: remove newly empty directories
Date: Mon, 5 Jul 2010 23:25:36 -0400
Message-ID: <AANLkTilDcpdekvsw9b4TN8QNpubs6wkpibXdzz2AkTf-@mail.gmail.com>
References: <1278368848-7037-1-git-send-email-price@ksplice.com>
	<7vsk3x5n35.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 05:25:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVyn2-0007gQ-Pq
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 05:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755704Ab0GFDZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 23:25:38 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:57568 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954Ab0GFDZh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 23:25:37 -0400
Received: by ewy23 with SMTP id 23so1743441ewy.19
        for <git@vger.kernel.org>; Mon, 05 Jul 2010 20:25:36 -0700 (PDT)
Received: by 10.213.14.20 with SMTP id e20mr3346196eba.21.1278386736066; Mon, 
	05 Jul 2010 20:25:36 -0700 (PDT)
Received: by 10.213.14.129 with HTTP; Mon, 5 Jul 2010 20:25:36 -0700 (PDT)
In-Reply-To: <7vsk3x5n35.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150319>

On Mon, Jul 5, 2010 at 11:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Will this keep refs/heads/p/q that is empty after packing p/q/r/s branch
> that happens to be the only branch whose name begins with p/?
>
> I do not want a careless loop that will remove refs/heads after packing
> "master" that happens to be the only local branch, but still...

It will.  I could fix that with something like this (untested):

/* Remove empty parents, but spare refs/ and immediate subdirs.
   Note, munges *name. */
static void try_remove_empty_parents(char *name)
{
  char *p, *q;
  int i;
  p = name;
  for (i = 0; i < 2; i++) { /* refs/{heads,tags,...}/ */
    while (*p && *p != '/')
      p++;
    if (*p)
      p++;
  }
  for (q = p; *q; q++)
    ;
  while (1) {
    for ( ; q > p && *q != '/'; q--)
      ;
    if (q == p)
      break;
    *q = '\0';
    if (rmdir(git_path("%s", name)))
      break;
  }
}

and then

      if (lock) {
              unlink_or_warn(git_path("%s", r->name));
              unlock_ref(lock);
+              try_remove_empty_parents(r->name);
      }

Sound reasonable?

Greg
