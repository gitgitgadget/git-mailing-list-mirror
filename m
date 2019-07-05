Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D30171F461
	for <e@80x24.org>; Fri,  5 Jul 2019 00:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfGEAWU (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jul 2019 20:22:20 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:50174 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727093AbfGEAWU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jul 2019 20:22:20 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1hjBzU-00054B-55
        for git@vger.kernel.org; Fri, 05 Jul 2019 09:22:16 +0900
Date:   Fri, 5 Jul 2019 09:22:16 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Subject: Re: Surprising use of memory and time when repacking mozilla's gecko
 repository
Message-ID: <20190705002216.logqmvrk5s354jss@glandium.org>
References: <20190704100530.smn4rpiekwtfylhz@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704100530.smn4rpiekwtfylhz@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 04, 2019 at 07:05:30PM +0900, Mike Hommey wrote:
> Hi,
> 
> I was looking at the disk size of the gecko repository on github[1],
> which started at 4.7GB, and `git gc --aggressive`'d it, which made that
> into 2.0G. But to achieve that required quite some resources.
> 
> My first attempt failed with OOM, on an AWS instance with 16 cores and
> 32GB RAM. I then went to another AWS instance, with 36 cores and 96GB
> RAM. And that went through after a while... with a peak memory usage
> above 60GB!
> 
> Since then, Peff kindly repacked the repo on the github end, so it
> doesn't really need repacking locally anymore, but I can still reproduce
> the > 60GB memory usage with the packed repository.
> 
> I gathered some data[2], all on the same 36 cores, 96GB RAM instance, with
> 36, 16 and 1 threads, and here's what can be observed:
> 
> With 36 threads, the overall process takes 45 minutes:
> - 50 seconds enumerating and counting objects.
> - ~22 minutes compressing objects
> - ~22 minutes writing objects
> 
> Of the 22 minutes compressing objects, more than 15 minutes are spent on
> the last percent of objects, and only during that part the memory usage
> balloons above 20GB.
> 
> Memory usage goes back to 2.4G after finishing to compress.
> 
> With 16 threads, the overall process takes about the same time as above,
> with about the same repartition.
> 
> But less time is spent on compressing the last percent of objects, and
> memory usage goes above 20GB later than with 36 threads.
> 
> Finally, with 1 thread, the picture changes greatly. The overall process
> takes 2.5h:
> - 50 seconds enumerating and counting objects.
> - ~2.5h compressing objects.
> - 3 minutes and 25 seconds writing objects!
> 
> Memory usage stays reasonable, except at some point after 47 minutes,
> where it starts to increase up to 12.7GB, and then goes back down about
> half an hour later, all while stalling around the 13% progress mark.
> 
> My guess is all those stalls are happening when processing the files I
> already had problems with in the past[3], except there are more of them
> now (thankfully, they were removed, so there won't be more, but that
> doesn't make the existing ones go away).
> 
> I never ended up working on trying to make that diff faster, maybe that
> would help a little here, but that would probably not help much wrt the
> memory usage. I wonder what git could reasonably do to avoid OOMing in
> this case. Reduce the window size temporarily? Trade memory with time,
> by not keeping the objects in memory?
> 
> I'm puzzled by the fact writing objects is so much faster with 1 thread.

Here's a perf report from the portion of "Writing" that is particularly
slow with compression having happened on 36 threads:
  100.00%     0.00%  git      [unknown]           [k] 0xffffffffffffffff                    
   99.97%     0.02%  git      git                 [.] write_one                             
   99.97%     0.00%  git      git                 [.] write_pack_file                       
   99.97%     0.00%  git      git                 [.] cmd_pack_objects                      
   99.96%     0.00%  git      git                 [.] write_object (inlined)                
   99.96%     0.00%  git      git                 [.] write_reuse_object (inlined)          
   99.92%     0.00%  git      git                 [.] write_no_reuse_object                 
   98.12%     0.00%  git      git                 [.] get_delta (inlined)                   
   72.36%     0.00%  git      git                 [.] diff_delta (inlined)                  
   64.86%    64.20%  git      git                 [.] create_delta_index                    
   26.32%     0.00%  git      git                 [.] repo_read_object_file (inlined)       
   26.32%     0.00%  git      git                 [.] read_object_file_extended             
   26.32%     0.00%  git      git                 [.] read_object                           
   26.32%     0.00%  git      git                 [.] oid_object_info_extended              
   26.25%     0.00%  git      git                 [.] packed_object_info                    
   26.24%     0.00%  git      git                 [.] cache_or_unpack_entry (inlined)       
   24.30%     0.01%  git      git                 [.] unpack_entry                          
   17.62%     0.00%  git      git                 [.] memcpy (inlined)                      
   17.52%    17.46%  git      libc-2.27.so        [.] __memmove_avx_unaligned_erms          
   15.98%     0.22%  git      git                 [.] patch_delta                           
    7.60%     0.00%  git      git                 [.] unpack_compressed_entry               
    7.49%     7.42%  git      git                 [.] create_delta                          
    7.29%     0.00%  git      git                 [.] git_inflate                           
    7.29%     0.23%  git      libz.so.1.2.11      [.] inflate                               
    1.94%     0.00%  git      git                 [.] xmemdupz                              
    1.14%     0.00%  git      git                 [.] do_compress                           
    0.98%     0.98%  git      libz.so.1.2.11      [.] adler32_z                             
    0.95%     0.00%  git      libz.so.1.2.11      [.] deflate                               

... that's a large portion of time spent on deltas...

Mike
