Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273A0C2BA83
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 18:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA82217F4
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 18:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgBMStO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:49:14 -0500
Received: from smtprelay07.ispgateway.de ([134.119.228.100]:15758 "EHLO
        smtprelay07.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgBMStO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 13:49:14 -0500
X-Greylist: delayed 442 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Feb 2020 13:49:13 EST
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay07.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1j2JQr-0008Jd-93; Thu, 13 Feb 2020 19:41:49 +0100
Subject: Test program used to prove quota's behavior
To:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>
References: <pull.553.git.1581619239467.gitgitgadget@gmail.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <86c3fad5-4fa7-7bb0-37cc-7c43e6f2eedc@syntevo.com>
Date:   Thu, 13 Feb 2020 19:41:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <pull.553.git.1581619239467.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

///////////////////////////////////////////////////////////////////////////////
// NTDLL declarations
typedef struct _FILE_PIPE_LOCAL_INFORMATION {
	ULONG NamedPipeType;
	ULONG NamedPipeConfiguration;
	ULONG MaximumInstances;
	ULONG CurrentInstances;
	ULONG InboundQuota;
	ULONG ReadDataAvailable;
	ULONG OutboundQuota;
	ULONG WriteQuotaAvailable;
	ULONG NamedPipeState;
	ULONG NamedPipeEnd;
} FILE_PIPE_LOCAL_INFORMATION, * PFILE_PIPE_LOCAL_INFORMATION;

typedef struct _IO_STATUS_BLOCK
{
	union {
		DWORD Status;
		PVOID Pointer;
	} u;
	ULONG_PTR Information;
} IO_STATUS_BLOCK, * PIO_STATUS_BLOCK;

typedef enum _FILE_INFORMATION_CLASS {
	FilePipeLocalInformation = 24
} FILE_INFORMATION_CLASS, * PFILE_INFORMATION_CLASS;

typedef DWORD (WINAPI* PNtQueryInformationFile)(HANDLE, 
IO_STATUS_BLOCK*, VOID*, ULONG, FILE_INFORMATION_CLASS);
///////////////////////////////////////////////////////////////////////////////

ULONG GetPipeAvailWriteBuffer(HANDLE a_PipeHandle)
{
	static PNtQueryInformationFile NtQueryInformationFile = 
(PNtQueryInformationFile)GetProcAddress(GetModuleHandleW(L"ntdll.dll"), 
"NtQueryInformationFile");

	IO_STATUS_BLOCK statusBlock = {};
	FILE_PIPE_LOCAL_INFORMATION pipeInformation = {};
	if (0 != NtQueryInformationFile(a_PipeHandle, &statusBlock, 
&pipeInformation, sizeof(pipeInformation), FilePipeLocalInformation))
		assert(0);

	return pipeInformation.WriteQuotaAvailable;
}

void ReadPipe(HANDLE a_Pipe, DWORD a_Size)
{
	void* buffer = malloc(a_Size);
	DWORD bytesDone = 0;
	assert(ReadFile(a_Pipe, buffer, a_Size, &bytesDone, NULL));
	assert(bytesDone == a_Size);
	free(buffer);
}

void WritePipe(HANDLE a_Pipe, DWORD a_Size)
{
	void* buffer = malloc(a_Size);
	DWORD bytesDone = 0;
	assert(WriteFile(a_Pipe, buffer, a_Size, &bytesDone, NULL));
	assert(bytesDone == a_Size);
	free(buffer);
}

struct ThreadReadParam
{
	HANDLE Pipe;
	DWORD  Size;
};

DWORD WINAPI ThreadReadPipe(void* a_Param)
{
	const ThreadReadParam* param = (const ThreadReadParam*)a_Param;
	ReadPipe(param->Pipe, param->Size);
	return 0;
}

void Test()
{
	HANDLE readPipe  = 0;
	HANDLE writePipe = 0;
	const DWORD pipeBufferSize = 0x8000;
	assert(CreatePipe(&readPipe, &writePipe, NULL, pipeBufferSize));

	DWORD expectedBufferSize = pipeBufferSize;
	assert(expectedBufferSize == GetPipeAvailWriteBuffer(writePipe));

	// Test 1: nothing unexpected here.
	// Write some data to pipe, occupying portion of write buffer.
	{
		const DWORD size = 0x1000;
		WritePipe(writePipe, size);

		expectedBufferSize -= size;
		assert(expectedBufferSize == GetPipeAvailWriteBuffer(writePipe));
	}

	// Test 2: nothing unexpected here.
	// Read some of written data, releasing portion of write buffer.
	{
		const DWORD size = 0x0800;
		ReadPipe(readPipe, size);

		expectedBufferSize += size;
		assert(expectedBufferSize == GetPipeAvailWriteBuffer(writePipe));
	}

	// Test 3: nothing unexpected here.
	// Read remaining written data, releasing entire buffer.
	{
		const DWORD size = 0x0800;
		ReadPipe(readPipe, size);

		expectedBufferSize += size;
		assert(expectedBufferSize == GetPipeAvailWriteBuffer(writePipe));
	}

	// Test 4: that's the unexpected part.
	// Start reading the empty pipe and this reduces the *write* buffer.
	{
		ThreadReadParam param;
		param.Pipe = readPipe;
		param.Size = 0x8000;
		
		HANDLE thread = CreateThread(NULL, 0, ThreadReadPipe, &param, 0, NULL);
		Sleep(1000);
		
		expectedBufferSize -= param.Size;
		assert(expectedBufferSize == GetPipeAvailWriteBuffer(writePipe));

		// Write pipe to release thread
		WritePipe(writePipe, param.Size);
		WaitForSingleObject(thread, INFINITE);
		CloseHandle(thread);

		expectedBufferSize += param.Size;
		assert(expectedBufferSize == GetPipeAvailWriteBuffer(writePipe));
	}

	CloseHandle(writePipe);
	CloseHandle(readPipe);
}
