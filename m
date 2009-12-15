From: Jiri Slaby <jirislaby@gmail.com>
Subject: potential null dereference
Date: Tue, 15 Dec 2009 13:41:01 +0100
Message-ID: <4B2783DD.5060301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 15 13:41:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKWiH-0003kU-9y
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 13:41:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbZLOMlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2009 07:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbZLOMlH
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 07:41:07 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:46395 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbZLOMlD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2009 07:41:03 -0500
Received: by fg-out-1718.google.com with SMTP id e21so398543fga.1
        for <git@vger.kernel.org>; Tue, 15 Dec 2009 04:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=z+kHNU/i9E+BOWuYh3486MJG5wcHioplljuFvAEe7SM=;
        b=UYfaUqkuxx+nrcHerjDdzz+LJDKeFNyfNRMS9KBc0UIcOIhXvAnLGkhZdn/7XXUMkL
         ucJ1UPTOvmvd+GfkBNJMVGTwehJveBzaS4bixVrT6/z2RHK6x80Y/0ho2zsrBqg6WJTN
         AuT4IHmyGntpNUYUQvl49/XTA1P0ZyokNWGjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :x-enigmail-version:content-type:content-transfer-encoding;
        b=S92GJkMForK3ZthGQbnaA28dqo6ZMRU6t/LmO6UcxzBffY+P2PNDiZjRtcs+zVdVCw
         /sHqHwVsXoc50qHOnsMMUZkzOQ1vLTDUqSiLE0khWeHAlErDEx1T4um6DtUpZCj1O3Rn
         ytErbw5inAL7oWJIxnBAhnkJgvliva2utifys=
Received: by 10.87.38.33 with SMTP id q33mr138767fgj.3.1260880862495;
        Tue, 15 Dec 2009 04:41:02 -0800 (PST)
Received: from ?192.168.2.129? ([217.66.174.142])
        by mx.google.com with ESMTPS id d8sm13155771fga.18.2009.12.15.04.41.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 15 Dec 2009 04:41:02 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; cs-CZ; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-13.1 Thunderbird/3.0
X-Enigmail-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135284>

Hi,

Stanse found the following error in unpack-trees.c:
dereferencing NULL pointer here.[. * o src_index]

int unpack_trees(unsigned len, struct tree_desc *t, struct
unpack_trees_options *o)
{
 int ret;
 static struct cache_entry *dfc;
...
 if (o->src_index) {                   <-- loc0
  o->result.timestamp.sec = o->src_index->timestamp.sec;
  o->result.timestamp.nsec = o->src_index->timestamp.nsec;
 }
 o->merge_size = len;

 if (!dfc)
  dfc = xcalloc(1, ((1 + (0) + 8) & ~7));
 o->df_conflict_entry = dfc;

 if (len) {
...
 }

 if (o->merge) {
  while (o->pos < o->src_index->cache_nr) { <-- here

It triggers, because there is a test for o->src_index being NULL at
loc0, but here, it is dereferenced without a check. Can this happen
(e.g. does o->merge != NULL imply o->src_index != NULL)?






Further, there is a warning in log-tree.c:
pointer always points to valid memory here, but checking for not
NULL.[parents]

static int log_tree_diff(struct rev_info *opt, struct commit *commit,
struct log_info *log)
{
 int showed_log;
 struct commit_list *parents;
 unsigned const char *sha1 = commit->object.sha1;

 if (!opt->diff && !((&opt->diffopt)->flags & (1 << 14)))
  return 0;


 parents = commit->parents;
 if (!parents) {            <-- loc0
  if (opt->show_root_diff) {
   diff_root_tree_sha1(sha1, "", &opt->diffopt);
   log_tree_diff_flush(opt);
  }
  return !opt->loginfo;     <-- loc1
 }

 if (parents && parents->next) { <-- here

I.e. if parents was NULL at loc0, we escaped at loc1. But we check
parents against NULL here again.

thanks,
-- 
js
