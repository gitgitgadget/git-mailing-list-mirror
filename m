From: Michael Mueller <mmueller@vigilantsw.com>
Subject: New NULL dereference in sequence.c
Date: Wed, 2 May 2012 01:45:54 -0700
Message-ID: <CANV9Rr9PFR7SA_3jB-6PRF_V+4yB-FsYEuX5gs-LMpoTAxGDCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 02 10:46:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPVCC-0003aV-8b
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 10:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755807Ab2EBIp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 May 2012 04:45:56 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:54287 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755303Ab2EBIpz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 04:45:55 -0400
Received: by qcro28 with SMTP id o28so178197qcr.19
        for <git@vger.kernel.org>; Wed, 02 May 2012 01:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-originating-ip:date:message-id:subject:from:to
         :content-type:x-gm-message-state;
        bh=GoUXMFNQyl0T+WXTCsKvpsUog60RAhtooHW29LG+zOQ=;
        b=HJwCjGPt4woNK/pD8FYjrE3CDJO5K8or/4B1g3A2SC0aAuvcLfAQFE5l85BclJQGBu
         21EocfxfTQbITEXGaYiaiuh9jPhPecWUFTiVnXCGqg/TKLA4sCan3cncMINvoYcoAge7
         onfVvtaC/LYbT8/VBnBPhzZ3VELmHKnQWepbZDku+84A9NMEY6Q/c5Y0weJbYdX6Rlvg
         ujDNesUC0xKKVewR5lvBfYURzTvXwUdRTu6+H5joQHpyc5IjjD1ewkUwoKqPbZ8gD1tA
         aiqu2gWg5eV7CYnPIU2TDHAU2ZyWCwUx1glw8zdEsHgYyacURD8zBCG9vBHY3Ji55T7w
         hefg==
Received: by 10.224.1.135 with SMTP id 7mr8624471qaf.16.1335948354246; Wed, 02
 May 2012 01:45:54 -0700 (PDT)
Received: by 10.229.15.139 with HTTP; Wed, 2 May 2012 01:45:54 -0700 (PDT)
X-Originating-IP: [67.180.177.185]
X-Gm-Message-State: ALoCoQmX4SoihAG2N/zo5b0+4KV/LA1sqrql1Qj02upSRcepJLf9ZRRmDzEZi6M1PYiBD12gfcE+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196794>

Hi all,

The last defect Sentry picked up has been removed, yay!  At the same
time, a new NULL dereference bug appeared, in sequencer.c:

    static int is_index_unchanged(void)
    {
        unsigned char head_sha1[20];
        struct commit *head_commit;

        if (!resolve_ref_unsafe("HEAD", head_sha1, 1, NULL))
            return error(_("Could not resolve HEAD commit\n"));

        head_commit = lookup_commit(head_sha1);
        if (!head_commit || parse_commit(head_commit))
            return error(_("could not parse commit %s\n"),
                     sha1_to_hex(head_commit->object.sha1));

In the last line quoted above, head_commit may be NULL, and it is
dereferenced in the call to sha1_to_hex.  Assuming lookup_commit(head_sha1)
can return NULL, this function will segfault.

Introduced here:
https://github.com/gitster/git/commit/b27cfb0#sequencer.c

Mike

-- 
Mike Mueller
Phone: (401) 405-1525
Email: mmueller@vigilantsw.com

http://www.vigilantsw.com/
