From: Dmitry Ivankov <divanorama@gmail.com>
Subject: long fast-import errors out "failed to apply delta"
Date: Thu, 7 Jul 2011 16:47:31 +0600
Message-ID: <CA+gfSn8jjptyv10iVimmfXpf6QHrR_3UpkRdd+Dv1M=KgORtGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 07 12:47:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qem7T-0004RI-Js
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jul 2011 12:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753058Ab1GGKrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jul 2011 06:47:33 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:61023 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136Ab1GGKrc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jul 2011 06:47:32 -0400
Received: by qyk9 with SMTP id 9so477287qyk.19
        for <git@vger.kernel.org>; Thu, 07 Jul 2011 03:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=/J/lSmGSw0zSSjtPPgNwRIy4/zT9SeP5ZstYGXfZQN0=;
        b=O3YHwRCzRXyoxHxMNKPGCmNq2Lc91byXWOvFHTXEURJ5pY6vzwT/MEXh2DItE9+AW0
         mH+94YXQ4/l2PvvGrieDm+Sz8wNO6bdfwC38Fzy4Fi732FA4yyUyZBqSaY8bu12BwsBa
         MtYbU2Mkj7JPy/q3T+0cYf30XCWIeNmRjFHoA=
Received: by 10.229.41.136 with SMTP id o8mr478624qce.83.1310035651164; Thu,
 07 Jul 2011 03:47:31 -0700 (PDT)
Received: by 10.229.212.206 with HTTP; Thu, 7 Jul 2011 03:47:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176753>

Hi,

I'm getting a strange error from git-fast-import.
Tested on v1.7.5 and v1.7.6 on two machines (gentoo amd64 8gb ram,
3-core amd cpu; gentoo x86 2gb ram, 1-core intel mobile cpu).
The crash is stable - same message, instruction and deepest function
(patch_delta) parameters contents.

$ git fast-import --quiet < big_dump
fatal: failed to apply delta
fast-import: dumping crash report to fast_import_crash_7700

Where big_dump is produced by svn-fe, 3.3Gb, 43404 sequential commits
(in fact 43403, 43404th causes a crash in the middle) to a single
branch with a "mark" and "progress" commands for each commit.
Crash report doesn't give much hints:
The last commands are
commit refs/heads/master
mark :43404
committer ...
data 53
[a few "ls ..." & "M 100644 ...", one "M 100755 ..."]
  ls :43402 incubator/directory/seda/trunk/impl/src/java/org/apache/seda/processor/RequestProcessorMonitorAdapter.java
* M 100644 64d6fb598ba6b6a3f8418e62ea9bceb0cefe4481
incubator/directory/seda/trunk/api/src/java/org/apache/seda/protocol/RequestProcessorMonitorAdapter.java

The failure is in sha1_file.c:unpack_delta_entry on unpacking
something like depth=7 tree on the path to that file.

And the failure comes from:
void *patch_delta(const void *src_buf, unsigned long src_size,
                  const void *delta_buf, unsigned long delta_size,
                  unsigned long *dst_size)
...
        size = get_delta_hdr_size(&data, top);
        if (size != src_size)
                return NULL;

Where size is arount 590(don't remember, can gdb again if needed or it
can be extracted from the dumped delta_data), and src_size is 396. One
can inspect the parameters with a program at the bottom of this email.

I tried to add a "checkpoint" command before the failing commit - no effect.
And then I split the dump, imported commits that don't fail, with
--export-marks, run fast-import --import-marks on the remaining commit
dump and it didn't fail.

This looks strange to me.
Shouldn't checkpoint dump everything on the disk and have the same
effect as splitting the stream?
It doesn't look like an interrupted read of object because src_size is
always the same.

On a split run there is no delta resolution that visually looks like
the problematic one, the one that suits most has different base_size,
delta_size, delta_data is completely different and src_datas have some
common prefix of 14 bytes.

Any advices on debugging this?
I'll try valgrind for now.

---
test-apply-delta.c:
#include "git-compat-util.h"
#include "delta.h"

static const size_t base_size = 396;
static const unsigned char base_data[397] =
"\x31\x30\x30\x36\x34\x34\x20\x48\x61\x6E\x64\x6C\x65\x72\x54\x79\x70\x65\x45\x6E\x75\x6D\x2E\x6A\x61\x76\x61\x0\x9D\xF4\x1\x98\xF4\x69\x73\x58\x5\xCD\xC9\x5E\x19\x8E\xD0\x9E\x52\x3D\xA3\x4A\x31\x30\x30\x37\x35\x35\x20\x49\x6E\x65\x74\x53\x65\x72\x76\x69\x63\x65\x45\x6E\x74\x72\x79\x2E\x6A\x61\x76\x61\x0\x2\xA1\x5\x42\x84\xC5\xD0\x36\xFB\x20\x4F\x26\x59\x73\x8F\x8F\x49\x62\x19\x33\x31\x30\x30\x36\x34\x34\x20\x49\x6E\x65\x74\x53\x65\x72\x76\x69\x63\x65\x50\x72\x6F\x76\x69\x64\x65\x72\x2E\x6A\x61\x76\x61\x0\xAC\x24\xC6\x28\x6\x4\xD5\xC5\x4F\xF7\xE0\xBC\x97\x51\xF4\x55\xE5\x76\x17\x22\x31\x30\x30\x37\x35\x35\x20\x49\x6E\x65\x74\x53\x65\x72\x76\x69\x63\x65\x73\x44\x61\x74\x61\x62\x61\x73\x65\x2E\x6A\x61\x76\x61\x0\x6B\x49\x6F\x2E\x48\xDC\xF7\xB7\xD4\x7D\x2C\xFE\x97\xC8\xB\xF1\x39\x8B\x49\xFA\x
 31\x30\x30\x36\x34\x34\x20\x4D\x61\x6E\x79\x52\x65\x70\x6C\x79\x48\x61\x6E\x64\x6C\x65\x72\x2E\x6A\x61\x76\x61\x0\x50\xA0\x5B\x3A\x3\xDF\x8B\x8C\x6E\xE4\x79\x3E\xCA\xF6\x90\x48\xDB\xF3\xE9\x1B\x31\x30\x30\x36\x34\x34\x20\x4E\x6F\x52\x65\x70\x6C\x79\x48\x61\x6E\x64\x6C\x65\x72\x2E\x6A\x61\x76\x61\x0\x2F\x90\x8D\xC3\x6D\x8F\x6F\x49\xCC\x38\xF\x51\x4C\x9F\xD8\x2F\x58\x7D\x54\x41\x31\x30\x30\x36\x34\x34\x20\x52\x65\x71\x75\x65\x73\x74\x48\x61\x6E\x64\x6C\x65\x72\x2E\x6A\x61\x76\x61\x0\x13\x66\x67\x26\x2B\x4F\x84\xBF\x97\xC0\x4E\x5F\xEB\x90\x97\xC0\xF8\x72\x10\x75\x31\x30\x30\x36\x34\x34\x20\x53\x69\x6E\x67\x6C\x65\x52\x65\x70\x6C\x79\x48\x61\x6E\x64\x6C\x65\x72\x2E\x6A\x61\x76\x61\x0\xD7\x91\xF0\x9C\x25\xAE\x1E\x4F\xD8\x2\x47\x31\x37\x96\x70\x7E\x5\xCF\x49\x0";
static const size_t delta_size = 333;
static const unsigned char delta_data[334] =
"\xCF\x4\xCF\x4\x90\x1C\x14\xC5\x4F\x12\xA1\x4\xB1\x2D\xD6\xFE\xE9\x44\x66\x9A\xC\x99\x47\x74\xD7\x6C\xC7\x91\x30\x1D\x14\xAF\x4B\x19\xC8\xA3\x8B\xCC\x5C\x3E\x3C\xDA\xF6\xC4\x1C\x78\xF6\x86\xB3\x74\x56\x91\x61\x20\x14\x97\xE8\x87\xB8\xE6\x5A\x45\xB5\x33\x60\xB4\xBA\x87\x7F\xD7\x3B\x80\xA2\x61\x4B\x91\x95\x21\x14\x5\xF3\xED\xFD\xED\x9A\x85\xC2\x12\x23\x76\xCF\xCC\xF\x41\x39\xAA\xEB\x8D\xC1\x91\xCA\x1D\x14\x18\x9F\xB7\x73\xF0\x34\x90\xE4\x50\xA2\xA\x16\x53\x24\x33\xD\x94\x79\xE6\xDE\x91\xFB\x1B\x14\x9B\xC8\x11\x8\x8F\xA9\x7A\x3E\xF7\x16\xE\xDC\x38\x89\xC2\x4D\x93\x78\x16\xCE\x93\x2A\x1\x1B\x14\x83\x13\x6C\xDD\x24\x42\x7B\x36\x7\x77\x7D\x60\x28\x4D\xD1\x80\xDC\xC9\x27\x94\x93\x59\x1\x1D\x14\x1A\x9\x4E\x5E\xEF\x7\x35\x63\xCD\x71\xE9\x70\xBD\xF6\xC0\x27\xEE\x51\x2C\x29\x93\x8A\x1\x24\x7F\x49\x6
 D\x4B\x33\x55\x49\x95\xC0\x3D\x38\xDF\xA3\xF4\x6D\xBB\x67\x98\xB\xB9\xC1\x31\x30\x30\x36\x34\x34\x20\x53\x69\x6E\x67\x6C\x65\x52\x65\x70\x6C\x79\x48\x61\x6E\x64\x6C\x65\x72\x2E\x6A\x61\x76\x61\x0\x95\x72\x6A\xDA\x7B\x82\xFF\xFC\xD3\xD\x61\x63\xFF\x7A\x46\x34\x8F\x4\xFC\x13\x31\x30\x30\x37\x35\x35\x20\x54\x72\x61\x6E\x73\x70\x6F\x72\x74\x54\x79\x70\x65\x45\x6E\x75\x6D\x2E\x6A\x61\x76\x61\x0\x11\x6E\x4C\xF4\xCB\x97\xCF\x30\x1B\x93\xB3\xA7\x92\x4F\xE9\xB3\x46\xAF\xE3\x2\x31\x30\x30\x36\x34\x34\x93\x2D\x2\x22";

static long unsigned result_size;
static long unsigned *result_size_p = &result_size;
static void *result = NULL;

int main() {
	result = patch_delta(base_data, base_size, delta_data, delta_size,
result_size_p);
	return result == NULL ? 1 : 0;
}
