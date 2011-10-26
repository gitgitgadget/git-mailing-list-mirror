From: David Michael Barr <davidbarr@google.com>
Subject: FYI: status of svn-fe speed
Date: Wed, 26 Oct 2011 08:18:43 -0700
Message-ID: <CAFfmPPNK+D=g5h7bdYmON++HE5jF_opYxKLobqjOosj--8+9FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 17:18:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJ5Fj-0006UG-OR
	for gcvg-git-2@lo.gmane.org; Wed, 26 Oct 2011 17:18:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933325Ab1JZPSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Oct 2011 11:18:47 -0400
Received: from smtp-out.google.com ([216.239.44.51]:58074 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933076Ab1JZPSq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2011 11:18:46 -0400
Received: from hpaq3.eem.corp.google.com (hpaq3.eem.corp.google.com [172.25.149.3])
	by smtp-out.google.com with ESMTP id p9QFIjux029531
	for <git@vger.kernel.org>; Wed, 26 Oct 2011 08:18:45 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1319642326; bh=XRplFwGLmO0Tg+uYW6aOWxC4gAM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Cc:Content-Type;
	b=mOVkK24v3XaJvlpHkFNtI8FrmZSeg7Z4kyxZwYIQgDUTzuKxbR9qbPBgNUpt0Ix7N
	 i72VDpPTUSHnQNYfXc9yg==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=dkim-signature:mime-version:date:message-id:subject:from:to:cc:
	content-type:x-system-of-record;
	b=wapIMdkKhX1BxVaRoRsPfXsFNTAPNIhImIgls4juqrlwcHv9DuI2Z+DaLsK54AKvb
	HLyQYgiwQGoSn7fwBjKeQ==
Received: from gyd8 (gyd8.prod.google.com [10.243.49.200])
	by hpaq3.eem.corp.google.com with ESMTP id p9QFIIP0005707
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Wed, 26 Oct 2011 08:18:44 -0700
Received: by gyd8 with SMTP id 8so2431251gyd.2
        for <git@vger.kernel.org>; Wed, 26 Oct 2011 08:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :x-system-of-record;
        bh=E8oBe7Q5/IKQ6iOw8d9jtgFsVfM6t//oiUNAq/5Xos0=;
        b=XHcghOTVM1fGva02eKlgDWxqhO2oJVN+1p2JNXie7N6BgXAqlAOy5ZOruFV9DST9mq
         LfVtEFwPNHVy/ZBVPxjw==
Received: by 10.101.72.1 with SMTP id z1mr7186045ank.95.1319642324230;
        Wed, 26 Oct 2011 08:18:44 -0700 (PDT)
Received: by 10.101.72.1 with SMTP id z1mr7186036ank.95.1319642324085; Wed, 26
 Oct 2011 08:18:44 -0700 (PDT)
Received: by 10.100.24.25 with HTTP; Wed, 26 Oct 2011 08:18:43 -0700 (PDT)
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184263>

Hi,

I talked a lot about low-level speed optimisation after the high-level
optimisation is finished this week. I merged my svn-fe-pu branch with
jch/next and tested with a 1000 rev dump of patches from git-core.
When not blocked, svn-fe can process such revs at ~5000 rev/s on my
laptop. This is far above what both svnadmin dump and git fast-import
presently achieve and might be deemed excessive. However, this
translates to low latency which is critical for parallelisation.

I had to use a 10 microsecond sampling interval to get an accurate
profile. These numbers have not been normalised but are the complete
set of symbols sampled.
2.2%     parse_date_basic
1.5%         match_string
1.1%         svndump_read
1.1% 0x10000af70 [20.2KB]
0.4%          strbuf_grow
0.4%         strbuf_fread
0.4%           strbuf_add
0.4%        reset_rev_ctx
0.4%       next_quote_pos
0.4%              is_date
0.4%     fast_export_data
0.4%         end_revision
0.4%     buffer_read_line
0.4%    buffer_copy_bytes

I still think it ought to be a little faster. ;)
-- 
David Barr
