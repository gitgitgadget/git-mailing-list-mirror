From: Stefan Zager <szager@google.com>
Subject: Windows performance / threading file access
Date: Thu, 10 Oct 2013 11:18:12 -0700
Message-ID: <CAHOQ7J_ZZ=7j-5ULd7Tdvbiqg4inhwi+fue_w6WAtNRkvZSwsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 10 20:18:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUKoT-0000Xh-Pa
	for gcvg-git-2@plane.gmane.org; Thu, 10 Oct 2013 20:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756730Ab3JJSSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Oct 2013 14:18:14 -0400
Received: from mail-qa0-f45.google.com ([209.85.216.45]:52561 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755719Ab3JJSSN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Oct 2013 14:18:13 -0400
Received: by mail-qa0-f45.google.com with SMTP id k4so6477955qaq.11
        for <git@vger.kernel.org>; Thu, 10 Oct 2013 11:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=G2ZkqI1BTQeIx8HYTEgfn6UAkeHqnuF+MMswepfmAC8=;
        b=akNQtTKUP1DBI5gIosxo5HVSxjlMoCP8F60OZv3w+8sDlHrQS6rbC8BVarcB3XspQA
         tM8C7YSALD+uji04nh1dLo9laG+EFXybwNa++dnXRIkCSkrmOQGSpgv88ti+1F9N/Y0H
         A7c737hIw6kXJq3q6O/K8CvY/DBwzG4hUGAZVVQF93LUa8BGIJ2lzGUlDYb5DCwe+H2w
         sGHVJQTXZYcTHGnwgBcximOGHfsroCYT21c/UVAbYEjBdX2BERaE7cIbYwY/5yk6eAs5
         358k9L/fvlbxiSFEeyTLAv6kg+TSLGK3FsLJ0ZqWrFnO9fpTw1z0Ag8gc8CYMPOsRBMY
         K+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=G2ZkqI1BTQeIx8HYTEgfn6UAkeHqnuF+MMswepfmAC8=;
        b=D6BYwLLpol2ffGCpbEqKOqHd8oPCUviU5mxc8K8pf2sgNDfp6CLjNUGjZjHTZneciz
         jgR4L7kHDagZBHn8uep9HrFD4ngaeNEj8fgQwQKQijb+oxDOHRFOnkLQ0CIiCMSWHJfB
         rm01ri3ccMDqCcVtuuR0WuhZXp/pAXpvhRbGfUm52sPfctJTxccnivRLOYNV4yPoP2Da
         fxeUl3Hms2MfkVSK8udGeawqSPgOhvh4/qAbYWF5C7zQcWx6LJ8imD6SHxG33TgkFEMW
         rc76pJv28Nxg7gBGm8wwmYHLye2mu5nrNb42qsfRCIZUfUxO2UL5vIBRXqQiasWyoMhJ
         A19A==
X-Gm-Message-State: ALoCoQlVo/aziPgJr5CqNyaavIwnHRh4chtcaXi87iXDQLXmVjoFRiLCvoPK5UGcq/iuZ2YjywjSqhywCTNJKNwvrumoDuKxHl59++b71VtHmQrnuIU3VvVA3VrnCMnTzX2OwE0ppnEr7csrR/JlTnOL98I//ddsUlMncnveUFdBztxIITHGWuOOWWxoiyPq50pG7l0qMQix
X-Received: by 10.229.174.3 with SMTP id r3mr12932864qcz.10.1381429092455;
 Thu, 10 Oct 2013 11:18:12 -0700 (PDT)
Received: by 10.229.178.4 with HTTP; Thu, 10 Oct 2013 11:18:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235874>

Hi folks,

I don't follow the mailing list carefully, so forgive me if this has
been discussed before, but:

I've noticed that when working with a very large repository using msys
git, the initial checkout of a cloned repository is excruciatingly
slow (80%+ of total clone time).  The root cause, I think, is that git
does all the file access serially, and that's really slow on Windows.

Has anyone considered threading file access to speed this up?  In
particular, I've got my eye on this loop in unpack-trees.c:

static struct checkout state;
static int check_updates(struct unpack_trees_options *o)
{
        unsigned cnt = 0, total = 0;
        struct progress *progress = NULL;
        struct index_state *index = &o->result;
        int i;
        int errs = 0;

        ...

        for (i = 0; i < index->cache_nr; i++) {
                struct cache_entry *ce = index->cache[i];

                if (ce->ce_flags & CE_UPDATE) {
                        display_progress(progress, ++cnt);
                        ce->ce_flags &= ~CE_UPDATE;
                        if (o->update && !o->dry_run) {
                                errs |= checkout_entry(ce, &state, NULL);
                        }
                }
        }
        stop_progress(&progress);
        if (o->update)
                git_attr_set_direction(GIT_ATTR_CHECKIN, NULL);
        return errs != 0;
}


Any thoughts on adding threading around the call to checkout_entry?


Thanks in advance,

Stefan
