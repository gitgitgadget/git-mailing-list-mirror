From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH] fetch-pack: don't resend known-common refs in find_common
Date: Sun, 26 Oct 2014 16:39:33 +0100
Message-ID: <20141026153931.GA28288@spirit>
References: <1413884908.4175.49.camel@seahawk>
 <20141021144838.GA11589@seahawk>
 <xmqqd29l1f3p.fsf@gitster.dls.corp.google.com>
 <1413963706.11656.5.camel@seahawk>
 <xmqqfveghvw3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 26 16:42:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XiPxB-0008SK-Jw
	for gcvg-git-2@plane.gmane.org; Sun, 26 Oct 2014 16:42:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbaJZPjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2014 11:39:40 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:42402 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbaJZPji (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2014 11:39:38 -0400
Received: by mail-wg0-f44.google.com with SMTP id y10so4012311wgg.15
        for <git@vger.kernel.org>; Sun, 26 Oct 2014 08:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=swEpgBEAr8j9UT0gP4YGumWruXtRuC+H2mb05HpyO2Y=;
        b=BMx+6dyjaunh4jelyHKNmc4JjycwCdRwCxMCVnnvlZzFwGDPXkcoOSKCvdlSSqwVHl
         oWMCSVU0Q1aVIRvVDUfgHKPR8+E0bKbx84SdAHa6TEj27qQ3OmoUnZHu0OItWjx6mGCa
         mvjtd/RevBXwPvJ5TS3Da40PSoU2q8HMPsBVAr8llQ/4n7gRQeqMuLEDfyLN4ikSwLym
         TRULRM0eneLIZUJ8IzWYkz/KJRBRh+SZlo8OzKhXc6+f2QhekbgKEP+2AObGl+uQunjV
         IIgPygH6tWTpSU7PWumnx2Bdbbu14Re3C4U6M++s/hoXknxPW/At69XHMTSM1d9faFKH
         vJFg==
X-Gm-Message-State: ALoCoQn/G4zlB4+GtwRZMvtIbKf9o/ReUmJR84UxG90FnGEaBZo1iRWsfj+Q9vE2RIViddEWfmyS
X-Received: by 10.180.13.11 with SMTP id d11mr15855462wic.19.1414337976628;
        Sun, 26 Oct 2014 08:39:36 -0700 (PDT)
Received: from spirit (195-240-45-142.ip.telfort.nl. [195.240.45.142])
        by mx.google.com with ESMTPSA id bi7sm8680934wib.17.2014.10.26.08.39.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 26 Oct 2014 08:39:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqfveghvw3.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 22, 2014 at 10:11:40AM -0700, Junio C Hamano wrote:
> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
> 
> > On di, 2014-10-21 at 10:56 -0700, Junio C Hamano wrote:
> >> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
> >> 
> >> > By not clearing the request buffer in stateless-rpc mode, fetch-pack
> >> > would keep sending already known-common commits, leading to ever bigger
> >> > http requests, eventually getting too large for git-http-backend to
> >> > handle properly without filling up the pipe buffer in inflate_request.
> >> > ---
> >> > I'm still not quite sure whether this is the right thing to do, but make
> >> > test still passes :) The new testcase demonstrates the problem, when
> >> > running t5551 with EXPENSIVE, this test will hang without the patch to
> >> > fetch-pack.c and succeed otherwise.
> >> 
> >> IIUC, because "stateless" is just that, i.e. the server-end does not
> >> keep track of what is already known, not telling what is known to be
> >> common in each request would fundamentally break the protocol.  Am I
> >> mistaken?
> >
> > That sounds plausible, but why then does the fetch complete with this
> > line removed, and why does 'make test' still pass?
> 
> The fetch-pack program tries to help the upload-pack program(s)
> running on the other end find what nodes in the graph both
> repositories have in common by sending what the repository on its
> end has.  Some commits may not be known by the other side (e.g. your
> new commits that haven't been pushed there that are made on a branch
> forked from the common history), and some others may be known
> (i.e. you drilled down the history from the tips of your refs and
> reached a commit that you fetched from the common history
> previously).  The latter are ACKed by the upload-pack process and
> are remembered to be re-sent to the _next_ incarnation of the
> upload-pack process when stateless RPC is in use.
> 
> With your patch, you stop telling the upload-pack process what these
> two programs already found to be common in their exchange.  After
> the first exchange, fetch-pack and upload-pack may have noticed that
> both ends have version 2.0, but because you do not convey that fact
> to the other side, the new incarnation of upload-pack may end up
> deciding that the version 1.9 is the newest common commit between
> the two, and sending commits between 1.9 and 2.0.
> 
> If you imagine an extreme case, it would be easy to see why "the
> fetch completes" and "make test passes" are not sufficient to say
> anything about this change.  Even if you break the protocol in in a
> way different from your patch, by not sending any "have", such a
> butchered "fetch-pack" will become "fetch everything from scratch",
> aka "clone".  The end result will still have correct history and
> "fetch completes" would be true.
> 
> But I'd prefer deferring a more detailed analysis/explanation to
> Shawn, as stateless RPC is his creation.

Thanks for the explanation, that makes it quite clear that this approach
is wrong. The patch below (apologies for the formatting, I'm not quite
sure how to use format-patch in this situation) does it differently: by
buffering upload-pack's output until it has read all the input, the new
test still succeeds and again 'make test' passes. 

---
 t/t5551-http-fetch-smart.sh | 32 ++++++++++++++++++++++++++++++++
 upload-pack.c               | 29 +++++++++++++++++++----------
 2 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 6cbc12d..2aac237 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -245,5 +245,37 @@ test_expect_success EXPENSIVE 'clone the 50,000 tag repo to check OS command lin
 	)
 '
 
+test_expect_success EXPENSIVE 'create 50,000 more tags' '
+	(
+	cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	for i in `test_seq 50001 100000`
+	do
+		echo "commit refs/heads/too-many-refs-again"
+		echo "mark :$i"
+		echo "committer git <git@example.com> $i +0000"
+		echo "data 0"
+		echo "M 644 inline bla.txt"
+		echo "data 4"
+		echo "bla"
+		# make every commit dangling by always
+		# rewinding the branch after each commit
+		echo "reset refs/heads/too-many-refs-again"
+		echo "from :50001"
+	done | git fast-import --export-marks=marks &&
+
+	# now assign tags to all the dangling commits we created above
+	tag=$(perl -e "print \"bla\" x 30") &&
+	sed -e "s|^:\([^ ]*\) \(.*\)$|\2 refs/tags/$tag-\1|" <marks >>packed-refs
+	)
+'
+
+test_expect_success EXPENSIVE 'fetch the new tags' '
+	(
+		cd too-many-refs &&
+		git fetch --tags &&
+		test $(git for-each-ref refs/tags | wc -l) = 100000
+	)
+'
+
 stop_httpd
 test_done
diff --git a/upload-pack.c b/upload-pack.c
index ac9ac15..3d76750 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -373,6 +373,7 @@ static int get_common_commits(void)
 	int got_common = 0;
 	int got_other = 0;
 	int sent_ready = 0;
+	struct strbuf resp_buf = STRBUF_INIT;
 
 	save_commit_buffer = 0;
 
@@ -384,15 +385,19 @@ static int get_common_commits(void)
 			if (multi_ack == 2 && got_common
 			    && !got_other && ok_to_give_up()) {
 				sent_ready = 1;
-				packet_write(1, "ACK %s ready\n", last_hex);
+				packet_buf_write(&resp_buf, "ACK %s ready\n", last_hex);
 			}
 			if (have_obj.nr == 0 || multi_ack)
-				packet_write(1, "NAK\n");
+				packet_buf_write(&resp_buf, "NAK\n");
 
 			if (no_done && sent_ready) {
-				packet_write(1, "ACK %s\n", last_hex);
+				packet_buf_write(&resp_buf, "ACK %s\n", last_hex);
+				write_or_die(1, resp_buf.buf, resp_buf.len);
+				strbuf_release(&resp_buf);
 				return 0;
 			}
+			write_or_die(1, resp_buf.buf, resp_buf.len);
+			strbuf_release(&resp_buf);
 			if (stateless_rpc)
 				exit(0);
 			got_common = 0;
@@ -407,20 +412,20 @@ static int get_common_commits(void)
 					const char *hex = sha1_to_hex(sha1);
 					if (multi_ack == 2) {
 						sent_ready = 1;
-						packet_write(1, "ACK %s ready\n", hex);
+						packet_buf_write(&resp_buf, "ACK %s ready\n", hex);
 					} else
-						packet_write(1, "ACK %s continue\n", hex);
+						packet_buf_write(&resp_buf, "ACK %s continue\n", hex);
 				}
 				break;
 			default:
 				got_common = 1;
 				memcpy(last_hex, sha1_to_hex(sha1), 41);
 				if (multi_ack == 2)
-					packet_write(1, "ACK %s common\n", last_hex);
+					packet_buf_write(&resp_buf, "ACK %s common\n", last_hex);
 				else if (multi_ack)
-					packet_write(1, "ACK %s continue\n", last_hex);
+					packet_buf_write(&resp_buf, "ACK %s continue\n", last_hex);
 				else if (have_obj.nr == 1)
-					packet_write(1, "ACK %s\n", last_hex);
+					packet_buf_write(&resp_buf, "ACK %s\n", last_hex);
 				break;
 			}
 			continue;
@@ -428,10 +433,14 @@ static int get_common_commits(void)
 		if (!strcmp(line, "done")) {
 			if (have_obj.nr > 0) {
 				if (multi_ack)
-					packet_write(1, "ACK %s\n", last_hex);
+					packet_buf_write(&resp_buf, "ACK %s\n", last_hex);
+				write_or_die(1, resp_buf.buf, resp_buf.len);
+				strbuf_release(&resp_buf);
 				return 0;
 			}
-			packet_write(1, "NAK\n");
+			packet_buf_write(&resp_buf, "NAK\n");
+			write_or_die(1, resp_buf.buf, resp_buf.len);
+			strbuf_release(&resp_buf);
 			return -1;
 		}
 		die("git upload-pack: expected SHA1 list, got '%s'", line);
-- 
2.1.0-245-g26e60d4
