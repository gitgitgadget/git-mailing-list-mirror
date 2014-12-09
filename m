From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: fast-import should not care about core.ignorecase
Date: Mon, 08 Dec 2014 18:07:09 -0700
Message-ID: <54864B3D.6040503@workspacewhiz.com>
References: <20141209001211.GA13386@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 09 02:13:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy9N6-0007CC-P2
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 02:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291AbaLIBNo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 20:13:44 -0500
Received: from hsmail.qwknetllc.com ([208.71.137.138]:43286 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754688AbaLIBNo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 20:13:44 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Dec 2014 20:13:43 EST
Received: (qmail 11735 invoked by uid 399); 8 Dec 2014 18:07:05 -0700
Received: from unknown (HELO ?192.168.1.184?) (jjensen@workspacewhiz.com@207.225.223.75)
  by hsmail.qwknetllc.com with ESMTPAM; 8 Dec 2014 18:07:05 -0700
X-Originating-IP: 207.225.223.75
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <20141209001211.GA13386@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261102>

Mike Hommey wrote on 12/8/2014 5:12 PM:
> While it makes sense for checkouts and local commits, it doesn't make
> sense to me that using git fast-import with the same import script would
> have a different behavior depending on whether the file system is
> case-sensitive or not.
I have used fast-import with Perforce inputs.  When you run a Windows 
Perforce server, filenames can be submitted with ANY case, but given the 
case insensitive nature of the file system, a synced Perforce file will 
end up using whatever case happens to be on the file system at that point.

That may not be clear, so here goes:

Revision 1: abc/DEF/ghi/FILE.dat

Revision 2: ABC/def/GHI/file.dat

^^ Yes, Perforce stores the filename internally in that manner and does 
not fold the case.

If you happen to sync Revision 2 on an empty directory tree, you'll get 
ABC/def/GHI/file.dat.  If you then sync Revision 1, the filename case 
remains ABC/def/GHI/file.dat.

Likewise, if you happen to sync Revision 1 into an empty directory tree, 
you'll get abc/DEF/ghi/FILE.dat.  If you then sync Revision 2, the 
filename case remains as abc/DEF/ghi/FILE.dat.

I was the one who originally submitted the patch for this some 4 years 
ago.  It was commit 50906e04e8f48215b0b09841686709b92a2ab2e4. 'git 
fast-import' with core.ignorecase=true will fold the case of the 
filename specified in Revision 2 to the case currently stored in the Git 
repository from Revision 1.

If it does not do this, then Git internally stores FILE.dat and 
file.dat, and bad things happen on case-insensitive file systems.

(Further, there are still a few paths into Git where 
core.ignorecase=true does not fold the case of the filename, and this 
can cause 'repository corruptions' on case-insensitive file systems.  
One such place is in 'git update-index' directly used by 'git gui'.  I 
really need to get this submitted, as we've been beating on it for a 
long time now, but here is the partial patch for informational purposes 
only.

I think it has been discussed before, but maybe Git needs a 
core.casefold in addition to core.ignorecase.)

-Josh

---------------------------- builtin/update-index.c 
----------------------------
index aaa6f78..4cfedc1 100644
@@ -99,6 +99,7 @@ static int add_one_path(const struct cache_entry *old, 
const char *path, int len
      memcpy(ce->name, path, len);
      ce->ce_flags = create_ce_flags(0);
      ce->ce_namelen = len;
+    fold_ce_name_case(&the_index, ce);
      fill_stat_cache_info(ce, st);
      ce->ce_mode = ce_mode_from_stat(old, st->st_mode);

@@ -234,6 +235,7 @@ static int add_cacheinfo(unsigned int mode, const 
unsigned char *sha1,
      memcpy(ce->name, path, len);
      ce->ce_flags = create_ce_flags(stage);
      ce->ce_namelen = len;
+    fold_ce_name_case(&the_index, ce);
      ce->ce_mode = create_ce_mode(mode);
      if (assume_unchanged)
          ce->ce_flags |= CE_VALID;
